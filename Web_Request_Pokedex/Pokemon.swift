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
    fileprivate var _id: Int!
    
    var name: String {
        return _name
    }

    var id: Int {
        return _id
    }
    
    init (name: String, id: Int) {
        self._name = name
        self._id = id
    }
    
}
