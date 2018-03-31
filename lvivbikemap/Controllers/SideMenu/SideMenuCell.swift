//
//  SideMenuCell.swift
//  ForgetMeNot
//
//  Created by Kristina Del Rio Albrechet on 11/6/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var sceneName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sceneName.text = ""
    }

    func configure(with text: String) {
        sceneName.text = text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = ThemeManager.shared.selectedColor
        } else {
            contentView.backgroundColor = ThemeManager.shared.unselectedColor
        }
    }
}

