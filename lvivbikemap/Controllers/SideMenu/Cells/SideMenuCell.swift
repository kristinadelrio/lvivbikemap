//
//  SideMenuCell.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import UIKit

class SideMenuCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
        imageView?.image = nil
    }

    func configure(with text: String, _ image: UIImage? = nil) {
        textLabel?.text = text
        imageView?.image = image
    }
}

