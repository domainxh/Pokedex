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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    @IBOutlet weak var bioMoves: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
        pokedexID.text = pokemon.id
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        defenseLabel.text = pokemon.defense
        baseAttack.text = pokemon.attack
        
    }


}
