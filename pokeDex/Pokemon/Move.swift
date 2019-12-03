//
//  Move.swift
//  pokeDex
//
//  Created by akiracaio on 30/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Move: Object, Mappable {
    
    @objc dynamic var name: String?
    @objc dynamic var url: String?
    var baseStat = RealmOptional<Int>()

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.name                                            <- map["move.name"]
        self.url                                             <- map["move.url"]
    }
}
