//
//  SpecieRequestFactory.swift
//  pokeDex
//
//  Created by akiracaio on 02/12/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import Alamofire

class SpecieRequestFactory{
    
    static func getSpecie(id: Int) -> DataRequest{
    
        return Alamofire.request("\(baseUrl)/pokemon-species/\(id)", method: .get)
    }

    
}
