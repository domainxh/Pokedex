//
//  Constants.swift
//  Web_Request_Pokedex
//
//  Created by Xiaoheng Pan on 1/1/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import Foundation

let URL_BASE = "https://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"

typealias DownloadComplete = () -> ()
// Which accepts a closure that takes in no parameters that returns nothing. () -> ()  is the same as () -> Void .
