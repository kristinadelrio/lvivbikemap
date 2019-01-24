//
//  CategoriesMediator.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 1/24/19.
//

import Foundation

class CategoriesMediator {
    
    private static let mediator = RealmObjectAdapter<CategoriesModel>()
    
    /// Returns filters model from the realm database
    static var categories: CategoriesModel {
        guard let categories = mediator.objects()?.first else {
            do {
                return try create()
            } catch let error {
                fatalError("\(error as NSError)")
            }
        }
        
        return categories
    }
    
    /// Creates FiltersModel from scratch
    ///
    /// - Returns: new FiltersModel
    private static func create() throws -> CategoriesModel {
        try RealmService.removeAll(of: CategoriesModel.self)
        return try mediator.create()
    }
}
