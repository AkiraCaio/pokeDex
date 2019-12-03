//
//  Ability.swift
//  pokeDex
//
//  Created by akiracaio on 27/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Ability: Object, Mappable {
    
    var is_hidden = RealmOptional<Bool>()
    var slot = RealmOptional<Int>()
    @objc dynamic var url: String?
    @objc dynamic var name: String?
    
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.name                                                   <- map["ability.name"]
        self.url                                                    <- map["ability.url"]
        self.is_hidden.value                                        <- map["is_hidden"]
        self.slot.value                                             <- map["slot"]
    }
}


