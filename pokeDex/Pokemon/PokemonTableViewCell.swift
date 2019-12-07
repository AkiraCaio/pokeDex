//
//  PokemonTableViewCell.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import UIKit
import Kingfisher

protocol PokemonTableViewCellDelegate {
    func atualizaFavPok(favorito: Bool, id: Int)
}

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelPokemonName: UILabel!
    
    @IBOutlet weak var imageViewTypeLeft: UIImageView!
    @IBOutlet weak var imageViewTypeRight: UIImageView!
    
    @IBOutlet weak var favView: UIView!
    
    var pokemon: PokemonView?
    
    var delegate: PokemonTableViewCellDelegate!
    
    var imageFav: UIImageView = {
        
        let image = UIImageView(image: UIImage(named: "pokebolaFavorito"))
        image.tintColor = UIColor.black
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let gradientFavImage = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.configScreen()
    }
    
    func bind(pokemon: PokemonView) {
        
        self.pokemon = pokemon
        
        self.labelId.text = PokemonViewModel.getIdPokemonString(pokemonView: pokemon)
        self.labelPokemonName.text = pokemon.name.firstUppercased
        self.imageViewPokemon.setImage(with: pokemon.image)
        
        if (pokemon.types.count < 2) {
            self.imageViewTypeLeft.isHidden = true
            
            if (!pokemon.types.isEmpty) {
                self.imageViewTypeRight.image = TypeViewModel.getImageType(pokemon.types[0].name)
            }
        }else{
            self.imageViewTypeLeft.isHidden = false
            
            self.imageViewTypeRight.image = TypeViewModel.getImageType(pokemon.types[0].name)
            self.imageViewTypeLeft.image = TypeViewModel.getImageType(pokemon.types[1].name)
        }
        
        self.pintaComoEuPinto()
        
    }
    
    @objc private func favoritoAction (){
        
        if let pokemon = self.pokemon {
            
            self.pokemon?.favorito = !pokemon.favorito
            
            self.delegate.atualizaFavPok(favorito: !pokemon.favorito, id: pokemon.id)
            
            PokemonViewModel.save(nomePokemon: pokemon.name, favorito: !pokemon.favorito)
            
            self.pintaComoEuPinto()
        }
    }
    
    private func configScreen() {
        self.configFavView()
        self.configImageFav()
        
    }
    
    private func configImageFav() {
        
        self.favView.addSubview(self.imageFav)
        
        self.imageFav.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PokemonTableViewCell.favoritoAction)))
        self.imageFav.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            self.imageFav.centerYAnchor.constraint(equalTo: self.favView.centerYAnchor),
            self.imageFav.centerXAnchor.constraint(equalTo: self.favView.centerXAnchor),
            self.imageFav.heightAnchor.constraint(equalToConstant: 60),
            self.imageFav.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configFavView() {
        
        self.favView.layer.cornerRadius = self.favView.frame.height / 2
        self.favView.clipsToBounds = true
        
    }
    
    private func pintaComoEuPinto() {
        
        if let pokemon = self.pokemon {
            if (pokemon.favorito) {
                
                let colorTop = UIColor(red: 221 / 255, green: 62 / 255, blue: 62 / 255, alpha: 1).cgColor
                let colorBottom = UIColor(red: 133 / 255, green: 69 / 255, blue: 37 / 255, alpha: 1).cgColor
                
                self.gradientFavImage.frame = self.favView.bounds
                self.gradientFavImage.colors = [colorTop, colorBottom]
                self.gradientFavImage.locations = [0.0, 1.0]
                
                self.favView.layer.insertSublayer(self.gradientFavImage, at: 0)
                
            }else {
                self.gradientFavImage.removeFromSuperlayer()
            }
        }
    }
    
}
