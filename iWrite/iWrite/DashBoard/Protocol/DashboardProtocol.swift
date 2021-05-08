//
//  DashboardProtocol.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 25/4/21.
//

import Foundation
import UIKit

protocol DashboardPresenterToViewProtocol: class {
    func getNotesList() -> [NoteEntity]?
}

protocol DashboardInteractorToPresenterProtocol: class {
    func getNotesList() -> [NoteEntity]?
    func deleteNotes(notes: NoteEntity?) -> Bool
}

protocol DashboardPresentorToInteractorProtocol: class {
    var presenter: DashboardInteractorToPresenterProtocol? { get set }
    var notesList: [NoteEntity]?{ get }
    func deleteNotes(notes: NoteEntity?) -> Bool
}

protocol DashboardViewToPresenterProtocol: class {
    var view: DashboardPresenterToViewProtocol? { get set }
    var interactor: DashboardPresentorToInteractorProtocol? { get set }
    var router: DashboardPresenterToRouterProtocol? { get set }
    var notesList: [NoteEntity]?{ get }
    func getNotesList() -> [NoteEntity]?
    func deleteNotes(notes: NoteEntity?) -> Bool
    
}

protocol DashboardPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
}
