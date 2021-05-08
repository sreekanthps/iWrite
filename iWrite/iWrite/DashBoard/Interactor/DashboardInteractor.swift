//
//  DashboardInteractor.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 25/4/21.
//

import Foundation

class DashboardInteractor: DashboardPresentorToInteractorProtocol{
    func deleteNotes(notes: NoteEntity?) -> Bool {
        return RealmConnection.shared.delete(notes)
    }
    
    var presenter: DashboardInteractorToPresenterProtocol?
    
    var notesList: [NoteEntity]? {
        return RealmConnection.shared.objects()
    }
    
    func getNotelist() -> [NoteEntity]? {
        return notesList
    }
 }


