//
//  PokemonRequestFactory.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import Alamofire

class PokemonRequestFactory{
    
    static func getPokemon(id: Int) -> DataRequest{
    
        return Alamofire.request("\(baseUrl)/pokemon/\(id)", method: .get)
    }
     
     static func getPokemons(offset: Int) -> DataRequest {
         
         let params: Parameters = ["offset": offset, "limit": 20]
         
         return Alamofire.request("\(baseUrl)pokemon", method: .get, parameters: params)
     }
    
}
