//
//  CategoriesModel.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 1/24/19.
//

import RealmSwift

class CategoriesModel: Object {
    
    @objc dynamic var rental = "5c49b18020f0c6e9f164f442"
    @objc dynamic var sharing = "5c49b18020f0c6e9f164f443"
    @objc dynamic var repair = "5c49b18020f0c6e9f164f444" // and stores
    @objc dynamic var stops = "5c49b18020f0c6e9f164f445"
    @objc dynamic var interestPlaces = "5c49b18020f0c6e9f164f446"
    @objc dynamic var paths = "5c49b18020f0c6e9f164f447"
    @objc dynamic var parking = "5c49b18020f0c6e9f164f448"
}
