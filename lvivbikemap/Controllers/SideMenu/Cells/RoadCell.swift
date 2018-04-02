//
//  RoadCell.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit

class RoadCell: UITableViewCell {
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fromTextField.placeholder = "From".localized
        toTextField.placeholder = "To".localized
    }
}
