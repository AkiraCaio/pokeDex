//
//  Specie.swift
//  pokeDex
//
//  Created by akiracaio on 02/12/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Specie: Object, Mappable {
    
    @objc dynamic var name: String?
    @objc dynamic var urlEvolutionChain: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.name                                                  <- map["name"]
        self.urlEvolutionChain                                     <- map["evolution_chain.url"]
    }
}
