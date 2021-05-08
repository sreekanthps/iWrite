//
//  NoteDetailsView.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 25/4/21.
//

import UIKit
import FlexLayout
import PinLayout



class NoteDetailsView: UIView {
    var noteStatus: NoteStatus = .Add
    enum Action: DelegateAction {
        case SaveNotes(header: String?, notes: String?)
        case DismissKeypad
     }
    weak var delegate: ActionDelegate?
    private let rootView: UIView = {
      let uiview = UIView()
        uiview.backgroundColor = UIColor.hexColor(Colors.backGround)
      return uiview
    }()
    private let lineView: UIView = {
      let uiview = UIView()
        uiview.backgroundColor = UIColor.hexColor("ff857e")
      return uiview
    }()
    
    private let notesTitle: UITextField = {
      let notesHeader = UITextField()
        notesHeader.placeholder = "Note's title"
        notesHeader.contentVerticalAlignment =  .bottom
        return notesHeader
    }()
    
    private let notesDetails: UITextView = {
      let notesDetails = UITextView()
        notesDetails.layer.borderWidth = 1
        notesDetails.layer.borderColor = UIColor.clear.cgColor
        notesDetails.layer.shadowColor = UIColor.hexColor("ff3a30").cgColor
        notesDetails.layer.cornerRadius = 10
        notesDetails.clipsToBounds = false
        notesDetails.layer.shadowOpacity=0.4
        notesDetails.layer.shadowOffset =  CGSize(width: 2, height: 2)
        notesDetails.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        return notesDetails
    }()
    
    private let saveButton: UIButton = {
      let saveButton = UIButton()
        saveButton.isEnabled = false
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = UIColor.hexColor("ff857e")
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle("SAVE NOTES", for: .normal)
        saveButton.addTarget(self, action: #selector(addDocumentButton(_:)), for: .touchUpInside)
      return saveButton
    }()
    
    @objc func addDocumentButton(_ sender: UIButton) {
        self.delegate?.actionSender(didReceiveAction: Action.SaveNotes(header: notesTitle.text, notes: notesDetails.text))
    }
    
    @objc func tapDone(sender: Any) {
        self.delegate?.actionSender(didReceiveAction: Action.DismissKeypad)
        enableSaveButton(enabled: true)
    }
    init() {
        super.init(frame: .zero)
        configure()
        layout()
    }
    convenience init(delegate: ActionDelegate) {
        self.init()
        self.delegate = delegate
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        notesTitle.delegate = self
        notesDetails.delegate = self
        notesTitle.addBottomBorder()
    }
    
    func updateNotes(withHeader header: String?, withNotes notes: String?) {
        notesTitle.text = header
        notesDetails.text = notes
        enableSaveButton(enabled: false)
    }
    
    func layout() {
        removeAllSubviewsAndRemoveFromSuperview()
        rootView.flex.marginHorizontal(15).define { (flex) in
            flex.addItem(notesTitle).height(50).marginTop(100)
            flex.addItem(lineView).height(1).marginTop(5)
            flex.addItem(notesDetails).marginTop(20).grow(2)
            flex.addItem(saveButton).height(40).marginTop(10).marginBottom(30)
        }
        addSubview(rootView)
    }
    private func enableSaveButton(enabled: Bool = false) {
        saveButton.isEnabled = enabled
        saveButton.backgroundColor = enabled ? UIColor.hexColor("ff3a30") : UIColor.hexColor("ff857e")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        rootView.pin.all()
        
        // Then let the flexbox container layout itself
        rootView.flex.layout()
    }
}

extension NoteDetailsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NoteDetailsView: UITextViewDelegate {
    
}
