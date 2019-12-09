//
//  EvolutionChain.swift
//  pokeDex
//
//  Created by akiracaio on 30/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
	
class EvolutionChain: Object, Mappable {
    
    var id = RealmOptional<Int>()
    @objc dynamic var pokemonBaseName: String?
    @objc dynamic var url: String?
    var evoluiPara = List<EvoluiPara>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id.value                             <- map["id"]
        self.pokemonBaseName                      <- map["chain.species.name"]
        self.url                                  <- map["chain.species.url"]
        self.evoluiPara                           <- (map["chain.evolves_to"], ListTransform<EvoluiPara>())
    }
}
