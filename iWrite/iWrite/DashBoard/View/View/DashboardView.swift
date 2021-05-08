//
//  DashboardView.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 24/4/21.
//

import UIKit
import FlexLayout
import PinLayout

 @objc protocol TableViewDelegte: class {
    @objc func numberofRows(section: Int) -> Int
    @objc func cellforRowat(cell: Any?, indexPath: IndexPath)
    @objc optional func numberOfSections() -> Int
    @objc func didSelectRowAt(indexPath: IndexPath)
    @objc optional func didDeleteRecord(indexPath: IndexPath)
}

@objc protocol ButtonClickDelegte: class {
   @objc func buttonPressed()
 }

class DashboardView: UIView {
    
    private let rootView: UIView = {
      let uiview = UIView()
        uiview.backgroundColor = UIColor.hexColor(Colors.backGround)
      return uiview
    }()
    private let tableContainer = UIView()
    private let plusView =  UIView()
    var tableView = UITableView()
    weak var delegate: TableViewDelegte?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    weak var buttonDelegate: ButtonClickDelegte?
    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.addTarget(self, action: #selector(addDocumentButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private var payButton: UIButton {
        let button = UIButton(frame: .zero)
        button.setBackgroundImage(UIImage(named: "addnotessmall"), for: .normal)
        button.frame = CGRect(x: Constants.size.screenWidth - 80, y: Constants.size.screenHeight - 150, width: 50.0, height: 50.0)
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(addDocumentButton(_:)), for: .touchUpInside)
        return button
    }
    init() {
        super.init(frame: .zero)
        configure()
        layout()
    }
    
    func updateView(nodocuments: Bool = false) {
        tableView.isHidden = nodocuments
        tableView.flex.isIncludedInLayout = !nodocuments
        plusView.isHidden = !nodocuments
        plusView.flex.isIncludedInLayout = nodocuments
        self.layoutSubviews()
        
    }
    private func configure() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.hexColor(Colors.backGround)
        tableView.estimatedRowHeight = 90
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NotesListCell.self, forCellReuseIdentifier: NotesListCell.reuseIdentifier)
        tableView.estimatedRowHeight = 90
        
    }
    
    func layout() {
        removeAllSubviewsAndRemoveFromSuperview()
        rootView.flex.define { (flex) in
            flex.addItem(tableView).height(90%).marginHorizontal(15).marginTop(30)
            flex.addItem(plusView).justifyContent(.center).width(100%).height(100%).define { (flex) in
                flex.addItem(plusButton).size(200).alignSelf(.center)
            }
        }
        addSubview(rootView)
        addSubview(payButton)
    }
    
    @objc func addDocumentButton(_ sender: UIButton) {
        self.buttonDelegate?.buttonPressed()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all()
        rootView.flex.layout()
    }
}

extension DashboardView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = delegate?.numberofRows(section: section) else {
            return 0
        }
        return rows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesListCell.reuseIdentifier, for: indexPath) as? NotesListCell else {
            return UITableViewCell()
        }
            delegate?.cellforRowat(cell: cell, indexPath: indexPath)
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.delegate?.didDeleteRecord?(indexPath: indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .none)
        }

        return [delete]

    }
    
}
