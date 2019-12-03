//
//  EvoluiParaViewModel.swift
//  pokeDex
//
//  Created by akiracaio on 03/12/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import RealmSwift

struct EvoluiParaView {
    var pokemonName:String = ""
    var evoluiPara: [EvoluiParaView] = []
}

class EvoluiParaViewModel {
    
    static func getAsView(evoluiPara: EvoluiPara?) -> EvoluiParaView{
        
        guard let evoluiPara = evoluiPara else{
            return EvoluiParaView()
        }

        var evoluiParaView = EvoluiParaView()
        
        evoluiParaView.pokemonName = evoluiPara.pokemonBaseName ?? "-"
        evoluiParaView.evoluiPara = EvoluiParaViewModel.getAsView(evoluiParaArray: evoluiPara.evoluiPara)

        return evoluiParaView
    }
    
    static func getAsView(evoluiParaArray: [EvoluiPara]) -> [EvoluiParaView] {

        var evoluiParaView: [EvoluiParaView] = []

        evoluiParaArray.forEach { (evoluiPara) in
            evoluiParaView.append(self.getAsView(evoluiPara: evoluiPara))
        }

        return evoluiParaView
    }

    static func getAsView(evoluiParaArray: List<EvoluiPara>) -> [EvoluiParaView] {

        var evoluiParaView: [EvoluiParaView] = []

        evoluiParaArray.forEach { (evoluiPara) in
            evoluiParaView.append(self.getAsView(evoluiPara: evoluiPara))
        }

        return evoluiParaView
    }
}
