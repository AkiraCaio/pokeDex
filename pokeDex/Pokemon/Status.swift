//
//  Status.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Status: Object, Mappable {
    
    var baseStat = RealmOptional<Int>()
    @objc dynamic var name: String?
    @objc dynamic var url: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.baseStat.value                                  <- map["base_stat"]
        self.name                                            <- map["stat.name"]
        self.url                                             <- map["stat.url"]
    }
}
