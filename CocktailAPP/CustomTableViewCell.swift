//
//  CustomTableViewCell.swift
//  CocktailAPP
//
//  Created by Pavel Tsyganov on 27.11.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var imageMakeUpView: UIImageView!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func configure(with makeUp: MakeUpElement) {
        
        brandLabel.text = makeUp.brand?.capitalized
        nameLabel.text = makeUp.name
        priceLabel.text = "\(makeUp.price ?? "0") $"
        
        DispatchQueue.global().async {
            let strigURL = makeUp.imageLink
            guard let url = URL(string: strigURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.imageMakeUpView.image = UIImage(data: imageData)
            }
        }
    }
}


