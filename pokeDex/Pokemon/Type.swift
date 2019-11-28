//
//  Type.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Type: Object, Mappable {
    
    var slot = RealmOptional<Int>()
    @objc dynamic var name: String?
    @objc dynamic var url: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.name                                           <- map["type.name"]
        self.url                                            <- map["type.url"]
        self.slot.value                                     <- map["slot"]

    }
}


