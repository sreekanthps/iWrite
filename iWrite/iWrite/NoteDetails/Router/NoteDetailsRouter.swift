//
//  NoteDetailsRouter.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 26/4/21.
//

import Foundation
import UIKit


class NoteDetailsRouter: NoteDetailsPresenterToRouterProtocol {
    static func createModule(withNote note: NoteEntity?, notestatus: NoteStatus) -> UIViewController {
        let view = NoteDetailsViewController(withNotes: note, notesStatus: notestatus)
        let presenter: NoteDetailsViewToPresenterProtocol & NoteDetailsInteractorToPresenterProtocol = NoteDetailsPresenter()
        let interactor:NoteDetailsPresentorToInteractorProtocol = NoteDetailsInteractor()
        let router: NoteDetailsPresenterToRouterProtocol = NoteDetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    
    
}
