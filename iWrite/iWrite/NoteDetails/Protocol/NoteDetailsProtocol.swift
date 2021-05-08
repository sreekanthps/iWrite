//
//  NoteDetailsProtocol.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 26/4/21.
//

import Foundation
import UIKit

protocol NoteDetailsPresenterToViewProtocol: class {
}

protocol NoteDetailsInteractorToPresenterProtocol: class {
}

protocol NoteDetailsPresentorToInteractorProtocol: class {
    var presenter: NoteDetailsInteractorToPresenterProtocol? { get set }
    func saveNotes(note: NoteEntity?) -> Bool?
    func updateNote(note: NoteEntity?) -> Bool?
    func getNotesList() -> [NoteEntity]?
}

protocol NoteDetailsViewToPresenterProtocol: class {
    var view: NoteDetailsPresenterToViewProtocol? { get set }
    var interactor: NoteDetailsPresentorToInteractorProtocol? { get set }
    var router: NoteDetailsPresenterToRouterProtocol? { get set }
    func saveNotes(note: NoteEntity?) -> Bool?
    func updateNote(note: NoteEntity?) -> Bool?
    var notesList: [NoteEntity]?{ get }
}

protocol NoteDetailsPresenterToRouterProtocol: class {
    static func createModule(withNote note: NoteEntity?,notestatus: NoteStatus) -> UIViewController
}
