//
//  MarkerDetailView.swift
//  lvivbikemap
//
//  Created by Kristina Del Rio Albrechet on 4/1/18.
//

import UIKit

class MarkerDetailView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loactionLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    @IBAction func onShowDetail(_ sender: UIButton) {
        
    }
    
    func prepareForReuse() {
        imageView.image = nil
        nameLabel.text = ""
        loactionLabel.text = ""
    }
}
