//
//  RealmObjectAdapter.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import Foundation
import RealmSwift

class RealmObjectAdapter<T: Object> {
    func objects() -> Results<T>? {
        return try? Realm().objects(T.self)
    }
    
    @discardableResult func create(_ value: [String: Any]? = nil) throws -> T {
        let object = T()
        
        if let value = value {
            object.setValuesForKeys(value)
        }
        
        let realm = try Realm()
        try realm.write {
            realm.add(object)
        }
        
        return object
    }
    
    func add(_ object: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(object)
        }
    }
    
    func edit(_ object: T, set value: [String: Any]) throws {
        let realm = try Realm()
        try realm.write {
            object.setValuesForKeys(value)
        }
    }
    
    func remove(_ object: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
}
