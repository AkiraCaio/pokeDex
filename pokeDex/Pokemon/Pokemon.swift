//
//  Pokemon.swift
//  pokeDex
//
//  Created by akiracaio on 20/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Pokemon: Object, Mappable {
    
    var abilities = List<Ability>()
    var height = RealmOptional<Float>()
    var id = RealmOptional<Int>()
    @objc dynamic var name: String?
    @objc dynamic var sprites: String?
    var types = List<Type>()
    var status = List<Status>()
    var weight = RealmOptional<Float>()
    
    @objc dynamic var favorito: Bool = false
    
    var evolucaoPokemon = RealmOptional<Int>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        self.abilities                              <- (map["abilities"], ListTransform<Ability>())
        self.height.value                           <- map["height"]
        self.id.value                               <- map["id"]
        self.name                                   <- map["name"]
        self.sprites                                <- map["sprites.front_default"]
        self.types                                  <- (map["types"], ListTransform<Type>())
        self.status                                 <- (map["stats"], ListTransform<Status>())
        self.weight.value                           <- map["weight"]
    }
}
