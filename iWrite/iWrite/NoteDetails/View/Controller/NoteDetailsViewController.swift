//
//  NoteDetailsViewController.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 25/4/21.
//

import UIKit

enum NoteStatus {
    case Edit
    case Add
}

class NoteDetailsViewController: UIViewController {
    var noteStatus: NoteStatus = .Add
    var presenter: NoteDetailsViewToPresenterProtocol?
    fileprivate var mainView : NoteDetailsView {
        return self.view as! NoteDetailsView
    }
    private var notedetails: NoteEntity? = nil
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if noteStatus == .Edit {
            mainView.updateNotes(withHeader: notedetails?.noteHeader, withNotes: notedetails?.noteText)
        }
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    init() {
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    convenience init(withNotes notes: NoteEntity?, notesStatus: NoteStatus) {
        self.init()
        self.notedetails = notes
        self.noteStatus = notesStatus
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        let view = NoteDetailsView(delegate: self)
        self.view = view
    }
    
    private func saveNotedetails(header: String?, title: String?) {
        var index = 1
        if let notesList = presenter?.notesList,  notesList.count > 0 {
            index += notesList.count
        }
        let date = Date()
        let notes: NoteEntity = NoteEntity(id: index, noteHeader: header ?? "", noteText: title ?? "", timestamp: date.unixTimestamp, datecreation: date, updatedDate: date, updateTime: date.unixTimestamp)
        if let _ = presenter?.saveNotes(note: notes) {
            let message = "Notes Add"
            showToast(message: message, seconds: 0.7)
        }
        
    }
    
    private func updateNotesDetails(header: String?, title: String?) {
        let date = Date()
//        let  newNote = NoteEntity(id: 1, noteHeader: header  ?? "", noteText: <#T##String#>, timestamp: <#T##Int64#>, datecreation: <#T##Date#>, updatedDate: <#T##Date?#>)
        notedetails?.noteHeader = header
        notedetails?.noteText = title
        notedetails?.dateUpdation = date
        notedetails?.updateTimestamp = date.unixTimestamp
        if let _ = presenter?.updateNote(note: notedetails) {
            let message = "Notes Update"
            showToast(message: message, seconds: 0.7)
        }
        
    }
    
    private func  showToast(message: String?, seconds: Double = 0.5) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.hexColor("ff857e")
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 12
        self.present(alert, animated: true)
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
            self.navigationController?.popViewController(animated: false)
        }
    }
   
}

extension NoteDetailsViewController: ActionDelegate {
    public func actionSender(didReceiveAction action: DelegateAction) {
        switch action {
        case NoteDetailsView.Action.SaveNotes(let header, let notes) :
            if self.noteStatus == .Add {
                saveNotedetails(header: header, title: notes)
            } else {
                self.updateNotesDetails(header: header, title: notes)
            }
        case NoteDetailsView.Action.DismissKeypad :
            self.view.endEditing(true)
        default: break
            
        }
       
    }
}

extension NoteDetailsViewController: NoteDetailsPresenterToViewProtocol {
    
}
