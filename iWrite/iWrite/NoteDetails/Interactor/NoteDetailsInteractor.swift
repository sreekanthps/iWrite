//
//  NoteDetailsInteractor.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 26/4/21.
//

import Foundation

class NoteDetailsInteractor: NoteDetailsPresentorToInteractorProtocol {
    var presenter: NoteDetailsInteractorToPresenterProtocol?
    
    func saveNotes(note: NoteEntity?) -> Bool? {
        return RealmConnection.shared.write(note)
    }
    
    func updateNote(note: NoteEntity?) -> Bool? {
        return RealmConnection.shared.update(note)
    }
    
    func getNotesList() -> [NoteEntity]? {
        return RealmConnection.shared.objects()
    }
    
    
}

