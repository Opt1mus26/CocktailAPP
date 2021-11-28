//
//  DetailViewController.swift
//  CocktailAPP
//
//  Created by Pavel Tsyganov on 28.11.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var makeUpDescriptionLabel: UILabel!

    var dataMakeUp: MakeUpElement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let brand = dataMakeUp?.brand else { return }
        guard let name = dataMakeUp?.name else { return }
        navigationItem.title = "\(brand.capitalized) - \(name)"
        brandLabel.text = dataMakeUp?.brand?.capitalized
        nameLabel.text = dataMakeUp?.name
        guard let price = dataMakeUp?.price else { return }
        priceLabel.text = "Цена: \(price)$"
        makeUpDescriptionLabel.text = dataMakeUp?.makeUpDescription
        
    DispatchQueue.global().async {
        let strigURL = self.dataMakeUp.imageLink
        guard let url = URL(string: strigURL) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: imageData)
        }
    }
    }
}
