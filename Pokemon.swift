//
//  Pokemon.swift
//  Pokedex
//
//  Created by Emre Kunt on 27/04/2017.
//  Copyright © 2017 usturlapp. All rights reserved.
//

import Foundation

public class Pokemon {
    private var _name :String!
    private var _pokeId : Int!

    var name : String{
        return _name
    }

    var pokeId : Int{
        return _pokeId
    }
    
    init(name: String, pokeid : Int) {
        self._name = name
        self._pokeId = pokeid
    }
    

    
    
    
}
