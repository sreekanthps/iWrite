//
//  NoteDetailsPresenter.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 26/4/21.
//

import Foundation

class NoteDetailsPresenter: NoteDetailsViewToPresenterProtocol {
    
    var view: NoteDetailsPresenterToViewProtocol?
    var interactor: NoteDetailsPresentorToInteractorProtocol?
    var router: NoteDetailsPresenterToRouterProtocol?
    
    var notesList: [NoteEntity]? {
        return interactor?.getNotesList()
    }
    
    func saveNotes(note: NoteEntity?) -> Bool? {
        return interactor?.saveNotes(note: note)
    }
    
    func updateNote(note: NoteEntity?) -> Bool? {
        return interactor?.updateNote(note: note)
    }
}

extension NoteDetailsPresenter: NoteDetailsInteractorToPresenterProtocol {
    
}
