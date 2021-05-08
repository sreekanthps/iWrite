//
//  DashboardPresenter.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 25/4/21.
//

import Foundation

class DashboardPresenter: DashboardViewToPresenterProtocol {
    
    
    var view: DashboardPresenterToViewProtocol?
    var interactor: DashboardPresentorToInteractorProtocol?
    var router: DashboardPresenterToRouterProtocol?
    
    var notesList: [NoteEntity]? {
        return interactor?.notesList
    }
    func deleteNotes(notes: NoteEntity?) -> Bool {
        guard let status = interactor?.deleteNotes(notes: notes) else { return false }
        return status
    }
}

extension DashboardPresenter: DashboardInteractorToPresenterProtocol {
    func getNotesList() -> [NoteEntity]? {
        return notesList
    }
}
