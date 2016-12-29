//
//  Pokecell.swift
//  Web_Request_Pokedex
//
//  Created by Xiaoheng Pan on 12/28/16.
//  Copyright © 2016 Xiaoheng Pan. All rights reserved.
//

import UIKit

class Pokecell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImg: UIImageView!
    
    var pokemon: Pokemon!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.id)")
    }
}
