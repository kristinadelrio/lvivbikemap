//
//  RealmService.swift
//
//  Created by Sergii Tarasov on 11/21/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let version: UInt64 = 1
    
    static func configure() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: version, migrationBlock: migrate)
    }
    
    static func write(_ writeClosure: ()->()) throws {
        let realm = try Realm()
        try realm.write {
            writeClosure()
        }
    }
    
    static func add(_ object: Object) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(object)
        }
    }
    
    static func remove(_ object: Object) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
    
    static func removeAll(of type: Object.Type) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(realm.objects(type))
        }
    }
    
    static func migrate(migration: Migration, oldVersion: UInt64) {
        
    }
}
