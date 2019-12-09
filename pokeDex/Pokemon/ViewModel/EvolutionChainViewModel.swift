//
//  EvolutionChainViewModel.swift
//  pokeDex
//
//  Created by akiracaio on 03/12/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import RealmSwift

struct EvolutionChainView {
    var pokemonName: String = ""
    var pokemonID: String = ""
    var evoluiPara: [EvoluiParaView] = []
}

class EvolutionChainViewModel {
    
    static func save(object: EvolutionChain){
        try? uiRealm.write {
            uiRealm.add(object, update: .all)
        }
    }
    
    static func getEvolutionChain(id: Int) -> EvolutionChainView{
        
        let result = uiRealm.object(ofType: EvolutionChain.self, forPrimaryKey: id)
        
        return self.getAsView(evolutionChain: result)
    }
    
    static func getAsView(evolutionChain: EvolutionChain?) -> EvolutionChainView{
        
        guard let evolutionChain = evolutionChain else{
            return EvolutionChainView()
        }
        
        var evolutionChainView = EvolutionChainView()
        
        evolutionChainView.pokemonName = evolutionChain.pokemonBaseName ?? "-"
        evolutionChainView.pokemonID = evolutionChain.url ?? "-"
        evolutionChainView.evoluiPara = EvoluiParaViewModel.getAsView(evoluiParaArray: evolutionChain.evoluiPara)
        
        return evolutionChainView
    }
    
    //TODO: Criar uma metodo para nao precisar ficar criando mais loops dentro da funcao
    
    static func getEvolutionPokemon(evolutionChain: EvolutionChainView) -> [[PokemonView]] {
        var evolutions: [[PokemonView]] = []
        
        if (!evolutionChain.evoluiPara.isEmpty) {
            
            for pokemon in evolutionChain.evoluiPara {
                evolutions.append( [PokemonViewModel.getPokemonView(id: evolutionChain.pokemonName), PokemonViewModel.getPokemonView(id: pokemon.pokemonName)] )
                
                if (!pokemon.evoluiPara.isEmpty){
                    for pokemonInterno in pokemon.evoluiPara {
                        evolutions.append( [PokemonViewModel.getPokemonView(id: pokemon.pokemonName), PokemonViewModel.getPokemonView(id: pokemonInterno.pokemonName)] )
                        
                        
                        if (!pokemonInterno.evoluiPara.isEmpty) {
                            for pokemonInterno2 in pokemonInterno.evoluiPara {
                                evolutions.append( [PokemonViewModel.getPokemonView(id: pokemonInterno.pokemonName), PokemonViewModel.getPokemonView(id: pokemonInterno2.pokemonName)] )
                            }
                            
                        }
                    }
                    
                    
                }
            }
        }
        
        return evolutions
    }
    
//    static func getEvlotuionPokemonID(evolutionChain: EvolutionChainView) -> [[PokemonView]] {
//        var evolutions: [[PokemonView]] = []
//
//        if (!evolutionChain.evoluiPara.isEmpty) {
//
//            for pokemon in evolutionChain.evoluiPara {
//                evolutions.append( [PokemonViewModel.getPokemonView(id: evolutionChain.pokemonName), PokemonViewModel.getPokemonView(id: pokemon.pokemonName)] )
//
//                if (!pokemon.evoluiPara.isEmpty){
//                    for pokemonInterno in pokemon.evoluiPara {
//                        evolutions.append( [PokemonViewModel.getPokemonView(id: pokemon.pokemonName), PokemonViewModel.getPokemonView(id: pokemonInterno.pokemonName)] )
//
//
//                        if (!pokemonInterno.evoluiPara.isEmpty) {
//                            for pokemonInterno2 in pokemonInterno.evoluiPara {
//                                evolutions.append( [PokemonViewModel.getPokemonView(id: pokemonInterno.pokemonName), PokemonViewModel.getPokemonView(id: pokemonInterno2.pokemonName)] )
//                            }
//
//                        }
//                    }
//
//
//                }
//            }
//        }
//
//        return evolutions
//    }
    
    
}
