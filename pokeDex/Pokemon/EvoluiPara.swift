//
//  EvoluiPara.swift
//  pokeDex
//
//  Created by akiracaio on 30/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class EvoluiPara: Object, Mappable {
    
    @objc dynamic var pokemonBaseName: String?
    var evoluiPara = List<EvoluiPara>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.pokemonBaseName                           <- map["species.name"]
        self.evoluiPara                                <- (map["evolves_to"], ListTransform<EvoluiPara>())
    }
}
