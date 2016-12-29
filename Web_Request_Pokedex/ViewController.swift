//
//  ViewController.swift
//  Web_Request_Pokedex
//
//  Created by Xiaoheng Pan on 12/28/16.
//  Copyright © 2016 Xiaoheng Pan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        parsePokemonCSV()
        initAudio()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pokecell", for: indexPath) as? Pokecell {
            
            let individualPokemon = pokemon[indexPath.row]
            cell.configureCell(individualPokemon)
            
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
                
                let ID = Int(row["id"]!)!
                let name = row["identifier"]!
                let individualPokemon = Pokemon(name: name, id: ID)
                pokemon.append(individualPokemon)
                
            }
        
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    
}

