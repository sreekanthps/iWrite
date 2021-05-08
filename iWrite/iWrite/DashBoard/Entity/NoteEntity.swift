//
//  File.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 25/4/21.
//

import Foundation
import RealmSwift

class NoteEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var noteHeader: String? = nil
    @objc dynamic var noteText: String? = nil
    @objc dynamic var timestamp: Int64 = 0
    @objc dynamic var datecreation: Date? = nil
    @objc dynamic var dateUpdation: Date? = nil
    @objc dynamic var updateTimestamp: Int64 = 0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int,noteHeader: String,noteText: String, timestamp: Int64,
                     datecreation: Date,
                     updatedDate: Date?,updateTime: Int64 = 0) {
        self.init() //Please note this says 'self' and not 'super'
        self.id = id
        self.noteHeader = noteHeader
        self.noteText = noteText
        self.timestamp = timestamp
        self.datecreation = datecreation
        self.dateUpdation = updatedDate
        self.updateTimestamp = updateTime
    }
}
