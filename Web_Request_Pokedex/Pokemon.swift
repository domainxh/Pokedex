//
//  Pokemon.swift
//  Web_Request_Pokedex
//
//  Created by Xiaoheng Pan on 12/28/16.
//  Copyright © 2016 Xiaoheng Pan. All rights reserved.
//

import Foundation


class Pokemon {
    fileprivate var _name: String!
    fileprivate var _id: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _defense: String!
    fileprivate var _attack: String!
    
    var name: String {
        return _name
    }

    var id: String {
        return _id
    }
    
    var height: String {
        return _height
    }
    
    var weight: String {
        return _weight
    }
    
    var defense: String {
        return _defense
    }
    
    var attack: String {
        return _attack
    }
    
    init (name: String, id: String, height: String, weight: String, defense: String, attack: String) {
        self._name = name
        self._id = id
        self._attack = attack
        self._defense = defense
        self._height = height
        self._weight = weight
    }
    
}
