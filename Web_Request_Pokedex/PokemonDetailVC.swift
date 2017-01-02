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
    @IBOutlet weak var nextEvoString: UILabel!
    @IBOutlet weak var currentEvo1: UIImageView!
    @IBOutlet weak var currentEvo2: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var bioMoves: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: pokemon.id)
        currentEvo1.image = image
        currentEvo2.image = image
        nameLabel.text = pokemon.name.capitalized
        pokedexID.text = pokemon.id
 
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }
    }

    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        heightLabel.text = pokemon.height
        defenseLabel.text = pokemon.defense
        weightLabel.text = pokemon.weight
        baseAttack.text = pokemon.attack
        typeLabel.text = pokemon.typelabel
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            nextEvoString.text = "No Evolutions"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            nextEvoString.text = str
        }
    }
    
}
