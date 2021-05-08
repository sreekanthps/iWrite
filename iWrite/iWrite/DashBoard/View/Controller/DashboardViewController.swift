//
//  DashboardViewController.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 24/4/21.
//

import UIKit

class DashboardViewController: UIViewController {
    // MARK: -  Properties
    var presenter: DashboardViewToPresenterProtocol?
    var notesList: [NoteEntity]? = nil
    
    fileprivate var mainView : DashboardView {
        return self.view as! DashboardView
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = .white
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "My Notes";
        self.navigationController?.navigationBar.barStyle = .default
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.hexColor("ff3a30")]
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.hexColor("ff3a30")]
        //navigationController?.setNavigationBarHidden(true, animated: animated)
        self.notesList = getNotesList()
        updateDashBord()
    }
    
    private func updateDashBord() {
        let count = notesList?.count ?? 0
        if count > 0 {
            self.mainView.tableView.reloadData()
        }
        self.mainView.updateView(nodocuments: count > 0 ? false : true)
    }
    
    init() {
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        let view = DashboardView()
        view.delegate = self
        view.buttonDelegate = self
        self.view = view
    }
    
    func addNotes(notes: NoteEntity?, noteStatus: NoteStatus = .Add) {
        let notesdetails = NoteDetailsRouter.createModule(withNote: notes, notestatus: noteStatus)
        if #available(iOS 13.0, *) {
            notesdetails.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            notesdetails.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(notesdetails, animated: false, completion: nil)
        } else {
            notesdetails.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(notesdetails, animated: false)
        }
//        notesdetails.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        notesdetails.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.present(notesdetails, animated: true, completion: nil)
    }
    
    
}

extension DashboardViewController: TableViewDelegte {
    func didSelectRowAt(indexPath: IndexPath) {
       guard let list = notesList else {
            return
        }
        self.addNotes(notes: list[indexPath.row], noteStatus: .Edit)
    }
    
    func numberofRows(section: Int) -> Int {
        return notesList?.count ?? 0
    }
    
    func cellforRowat(cell: Any?, indexPath: IndexPath) {
        guard let cellData = cell as? NotesListCell, let list = notesList  else {
            return
        }
        let notes = list[indexPath.row]
        cellData.configureCellata(withName: notes.noteHeader ?? "")
    }
    
    func didDeleteRecord(indexPath: IndexPath) {
        guard let list = notesList, list.count > 0 else { return}
        let status = presenter?.deleteNotes(notes: list[indexPath.row])
        print("didDeleteRecord : \(status)")
        notesList = presenter?.notesList
    }
}

extension DashboardViewController: DashboardPresenterToViewProtocol {
    
    func getNotesList() -> [NoteEntity]? {
        return presenter?.notesList
    }
}

extension DashboardViewController: ButtonClickDelegte {
    func buttonPressed() {
        self.addNotes(notes: nil, noteStatus: .Add)
    }
}
