//
//  PokemonService.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol PokemonServiceDelegate{
    
    func success(isFinished: Bool)
    func success()
    func failure(erro: String)
}

class PokemonService {
    var delegate: PokemonServiceDelegate!
    
    init(delegate: PokemonServiceDelegate) {
        self.delegate = delegate
    }
    
    func getPokemon(id: Int, isFinished: Bool) {
        PokemonRequestFactory.getPokemon(id: id).validate().responseObject { (response: DataResponse<Pokemon>) in
            
            switch response.result {
                
            case .success:
                if let pokemon = response.result.value {
                    PokemonViewModel.save(pokemon: pokemon)
                }
                
                self.delegate.success(isFinished: isFinished)
                
            case .failure(let erro):
                self.delegate.failure(erro: erro.localizedDescription)
            }
        }
    }
    
    func getPokemons(number: Int) {
        
        PokemonRequestFactory.getPokemons(offset: number).validate().responseArray(keyPath: "results") {(response: DataResponse<[Pokemon]>) in
            
            switch response.result {
                
            case .success:
                
                if let pokemons = response.result.value {
                    
                    for index in 1 ... pokemons.count {
                        self.getPokemon(id: (index + number), isFinished: pokemons.count < 20)
                    }

                } else {
                    self.delegate.success(isFinished: false)
                }
                
            case .failure(let erro):
                self.delegate.failure(erro: erro.localizedDescription)
            }
        }
    }
    
}
