//
//  PokemonDetailVC.swift
//  Web_Request_Pokedex
//
//  Created by Xiaoheng Pan on 12/29/16.
//  Copyright © 2016 Xiaoheng Pan. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
    }


}
