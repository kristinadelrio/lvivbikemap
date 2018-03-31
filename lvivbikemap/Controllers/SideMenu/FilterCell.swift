//
//  FilterCell.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 3/31/18.
//

import UIKit

class FilterCell: UITableViewCell {

    var isChecked: Bool = false {
        didSet {
            imageView?.image = isChecked ? #imageLiteral(resourceName: "ic_check_box") : #imageLiteral(resourceName: "ic_check_box_outline_blank")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.image = #imageLiteral(resourceName: "ic_check_box_outline_blank")
    }
    
    
    func configure(with text: String, state: Bool) {
        isChecked = state
        textLabel?.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = ""
        imageView?.image = #imageLiteral(resourceName: "ic_check_box_outline_blank")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        isChecked = selected
    }
}
