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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func bind(pokemon: PokemonView) {
        self.labelId.text = String(pokemon.id)
        self.labelPokemonName.text = pokemon.name
        self.imageViewPokemon.setImage(with: pokemon.image)
    }
    
}
