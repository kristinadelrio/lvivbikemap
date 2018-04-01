//
//  TableView+DequeCell.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier:
            String(describing: T.self), for: indexPath) as? T else {
            fatalError("TableViewHandler: Can't get data for cell of \(T.self) type")
        }
        
        return cell
    }
}
