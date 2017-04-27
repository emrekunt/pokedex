//
//  PokeCell.swift
//  Pokedex
//
//  Created by Emre Kunt on 27/04/2017.
//  Copyright © 2017 usturlapp. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon : Pokemon){
        self.pokemon = pokemon
        imageView.image = UIImage(named: "\(self.pokemon.pokeId)")
        pokeLabel.text = self.pokemon.name.capitalized    
    }
    
}
