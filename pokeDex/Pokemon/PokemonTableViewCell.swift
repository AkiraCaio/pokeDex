//
//  PokemonTableViewCell.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import UIKit
import Kingfisher

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelPokemonName: UILabel!
    
    @IBOutlet weak var imageViewTypeLeft: UIImageView!
    @IBOutlet weak var imageViewTypeRight: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
    }
    
    func bind(pokemon: PokemonView) {
        
        self.labelId.text = PokemonViewModel.getIdPokemonString(pokemonView: pokemon)
        self.labelPokemonName.text = pokemon.name
        self.imageViewPokemon.setImage(with: pokemon.image)
        
        if (pokemon.types.count < 2) {
            self.imageViewTypeLeft.isHidden = true
            
            self.imageViewTypeRight.image = TypeViewModel.getImageType(pokemon.types[0].name)
        }else{
            self.imageViewTypeLeft.isHidden = false

            self.imageViewTypeRight.image = TypeViewModel.getImageType(pokemon.types[0].name)
            self.imageViewTypeLeft.image = TypeViewModel.getImageType(pokemon.types[1].name)
        }
        
        
    }
    
}
