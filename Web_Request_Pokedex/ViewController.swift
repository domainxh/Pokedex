//
//  ViewController.swift
//  Web_Request_Pokedex
//
//  Created by Xiaoheng Pan on 12/28/16.
//  Copyright © 2016 Xiaoheng Pan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pokecell", for: indexPath) as? Pokecell {
            
            if inSearchMode {
                let individualPokemon = filteredPokemon[indexPath.row]
                cell.configureCell(individualPokemon)
            } else {
                let individualPokemon = pokemon[indexPath.row]
                cell.configureCell(individualPokemon)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
        
            for row in rows {
                
                let ID = row["id"]!
                let name = row["identifier"]!
                
                let individualPokemon = Pokemon(name: name, id: ID)
                pokemon.append(individualPokemon)
                
            }
        
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        
        var poke: Pokemon!
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let destination = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    destination.pokemon = poke // This is the var pokemon in PokemonDetailVC
                }
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemon.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func initAudio() {
        let musicURL = Bundle.main.url(forResource: "music", withExtension: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: musicURL)
            musicPlayer.prepareToPlay()
            musicPlayer.volume = 0.25
            musicPlayer.numberOfLoops = -1 // means it will loop continueously 
            musicPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.5
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true) // This is needed otherwise after inputting text and click search the keyboard doesn't go away
        } else {
            inSearchMode = true
            
            let text = searchBar.text!
            filteredPokemon = pokemon.filter( {$0.name.localizedStandardRange(of: text) != nil })
            
            // $0 can be think of as a placeholder for any and all objects in pokemon
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        // This is needed otherwise after inputting text and click search the keyboard doesn't go away
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        // This is needed otherwise after inputting text and click search the keyboard doesn't go away
    }
    
}

