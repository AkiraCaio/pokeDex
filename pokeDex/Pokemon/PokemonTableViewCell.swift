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
    
    @IBOutlet weak var favView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.configFavButton()
    }
    
    func bind(pokemon: PokemonView) {
        
        self.labelId.text = PokemonViewModel.getIdPokemonString(pokemonView: pokemon)
        self.labelPokemonName.text = pokemon.name.firstUppercased
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
    
    //TODO: Organizar esse metodo e criar o metodo para reconhecer o tap na view/image do favoritos.
    private func configFavButton() {
        
        self.favView.layer.cornerRadius = self.favView.frame.height / 2
        self.favView.clipsToBounds = true
        
        let colorTop = UIColor(red: 221 / 255, green: 62 / 255, blue: 62 / 255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 133 / 255, green: 69 / 255, blue: 37 / 255, alpha: 1).cgColor
        
        let gl = CAGradientLayer()
        gl.frame = self.favView.bounds
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        
        
        self.favView.layer.insertSublayer(gl, at: 0)
        
        let image = UIImageView(image: UIImage(named: "pokebolaFavorito"))
        image.tintColor = UIColor.black
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.favView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: self.favView.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: self.favView.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 60),
            image.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
}
