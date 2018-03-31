//
//  SideMenuCell.swift
//  ForgetMeNot
//
//  Created by Kristina Del Rio Albrechet on 11/6/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
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

