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
    var pokemonName:String = ""
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
        evolutionChainView.evoluiPara = EvoluiParaViewModel.getAsView(evoluiParaArray: evolutionChain.evoluiPara)
        
        return evolutionChainView
    }
    
}
