//
//  CategoryMapper.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 1/21/19.
//

import Foundation

class CategoryMapper {

    static func get(for id: String) -> UIImage? {
        switch id {
        case CategoriesMediator.categories.sharing: return UIImage(named: "bike sharing")
        case CategoriesMediator.categories.rental: return UIImage(named: "rental")
        case CategoriesMediator.categories.parking: return UIImage(named: "parking")
        case CategoriesMediator.categories.stops: return UIImage(named: "usefull stops")
        case CategoriesMediator.categories.interestPlaces: return UIImage(named: "places of interest")
        case CategoriesMediator.categories.repair: return UIImage(named: "bike store-repair")
        default: return nil
        }
    }
}
