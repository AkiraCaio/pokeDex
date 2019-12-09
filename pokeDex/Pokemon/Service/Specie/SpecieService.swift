//
//  SpecieService.swift
//  pokeDex
//
//  Created by akiracaio on 02/12/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol SpecieServiceDelegate{
    
    func sucessSpecie()
    func failureSpecie(erro: String)
}

class SpecieService {
    var delegate: SpecieServiceDelegate!
    
    init(delegate: SpecieServiceDelegate) {
        self.delegate = delegate
    }
    
    func getSpecie(id: Int) {

        SpecieRequestFactory.getSpecie(id: id).validate().responseObject { (response: DataResponse<Specie>) in
            
            switch response.result {
                
            case .success:
                if let specie = response.result.value {
                    PokemonViewModel.save(nomePokemon: specie.name ?? "-", idEvolutionChain: PokemonViewModel.getIdEvolutionChain(url: specie.urlEvolutionChain ?? "/0"))
                    
                    
                }
                self.delegate.sucessSpecie()
                
            case .failure(let erro):
                self.delegate.failureSpecie(erro: erro.localizedDescription)
            }
            
        }
    }

}
