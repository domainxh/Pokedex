//
//  Pokemon.swift
//  Web_Request_Pokedex
//
//  Created by Xiaoheng Pan on 12/28/16.
//  Copyright © 2016 Xiaoheng Pan. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {

    fileprivate var _name: String!
    fileprivate var _id: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _defense: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvolutionTxt: String!
    fileprivate var _nextEvolutionName: String!
    fileprivate var _nextEvolutionId: String!
    fileprivate var _nextEvolutionLevel: String!
    fileprivate var _pokemonURL: String!
    fileprivate var _typelabel: String!
    fileprivate var _description: String!
    
    var name: String { return _name }
    var id: String { return _id }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var typelabel: String {
        if _typelabel == nil {
            _typelabel = ""
        }
        return _typelabel
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    init (name: String, id: String) {
        self._name = name
        self._id = id
        self._pokemonURL = URL_BASE + URL_POKEMON + id
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] {
                    for type in types {
                        if let typeValue = type["name"] {
                            self._typelabel != nil ? (self._typelabel! += "/\(typeValue.capitalized)") : (self._typelabel = "\(typeValue.capitalized)")
                        }
                    }
                    
                }
                
//                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
//                   
//                    if let evolvedPoke = evolutions[0]["to"] as? String {
//                        if evolvedPoke.range(of: "mega") == nil {
//                            
//                            if let uri = evolutions[0]
//                            
//                            
//                        }
//                        if let level = evolutions[0]["level"] as? String {
//                            let evolvePoke = evolutions[0]["to"]
//                            self._nextEvo = "Next Evolution: \(evolvePoke!) - LVL \(level)"
//                        }
//                    }
//                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvo
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                    
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                }

                
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, AnyObject>], descriptions.count > 0 {
                    if let resource_url = descriptions[0]["resource_uri"] as? String {
                        let url = URL_BASE + resource_url
                        
                        Alamofire.request(url).responseJSON { response2 in
                            if let dict2 = response2.result.value as? Dictionary<String, AnyObject> {
                                
                                if let  description = dict2["description"] as? String {
                                    self._description = description
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
            }
            completed()
        }
    }
}
