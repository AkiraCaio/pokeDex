//
//  DetalhesViewController.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    
   
    var pokemon: PokemonView?
    var evolutionChain: EvolutionChainView?
    
    var specieService: SpecieService!
    var evolucaoService: EvolucaoService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configScreen()
        self.configService()
    }
    
    private func configService() {
        
        self.specieService = SpecieService(delegate: self)
        self.evolucaoService = EvolucaoService(delegate: self)
        
        if let pokemon = self.pokemon {
            self.specieService.getSpecie(id: pokemon.id)
        }
    }
    
    private func configScreen() {
        
        if let pokemon = self.pokemon {
            self.title = pokemon.name.firstUppercased
            
            self.view.backgroundColor = TypeViewModel.getColorType(pokemon.types.count == 2 ? pokemon.types[1].name : pokemon.types[0].name)
            
            
        }
            
        
    }
    
}

extension DetalhesViewController: SpecieServiceDelegate {
    func success() {
        
        self.pokemon = PokemonViewModel.getPokemonView(id: pokemon!.name)

        if let pokemon = self.pokemon {
            self.evolucaoService.getEvolucao(id: pokemon.evolutionChainId)
        }
    }
    
    func failure(erro: String) {
        
    }
    
    
}
extension DetalhesViewController: EvolucaoServiceDelegate {
    func successEvolution() {
        if let pokemon = self.pokemon {
            self.evolutionChain = EvolutionChainViewModel.getEvolutionChain(id: pokemon.evolutionChainId)
        }
        
    }
    
    func failureEvolution(erro: String) {
        
    }
    
}
