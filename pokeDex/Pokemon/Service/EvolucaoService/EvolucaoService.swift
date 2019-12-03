//
//  EvolucaoService.swift
//  pokeDex
//
//  Created by akiracaio on 30/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol EvolucaoServiceDelegate{
    
    func successEvolution()
    func failureEvolution(erro: String)
}

class EvolucaoService {
    var delegate: EvolucaoServiceDelegate!
    
    init(delegate: EvolucaoServiceDelegate) {
        self.delegate = delegate
    }
    
    func getEvolucao(id: Int) {
        EvolucaoRequestFactory.getEvolutionChain(id: id).validate().responseObject { (response: DataResponse<EvolutionChain>) in
            
            switch response.result {
                
            case .success:
                if let evolutionChain = response.result.value {
                    EvolutionChainViewModel.save(object: evolutionChain)
                }
                
                self.delegate.successEvolution()
                
            case .failure(let erro):
                self.delegate.failureEvolution(erro: erro.localizedDescription)
            }
        }
    }
    
}
