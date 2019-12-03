//
//  EvolucaoRequestFactory.swift
//  pokeDex
//
//  Created by akiracaio on 30/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import Alamofire

class EvolucaoRequestFactory{
    
    static func getEvolutionChain(id: Int) -> DataRequest{
    
        return Alamofire.request("\(baseUrl)evolution-chain/\(id)", method: .get)
    }
    
}
