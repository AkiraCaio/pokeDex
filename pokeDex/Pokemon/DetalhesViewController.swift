//
//  DetalhesViewController.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    
    @IBOutlet weak var info1StackView: UIStackView!
    @IBOutlet weak var info2View: UIView!
    
    @IBOutlet weak var imagePokemonImageView: UIImageView!
    
    @IBOutlet weak var hplabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var atackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var spAtackLabel: UILabel!
    @IBOutlet weak var spDefLabel: UILabel!
    
    @IBOutlet weak var abilidadesLabel: UILabel!
    
    @IBOutlet weak var comprimentoLabel: UILabel!
    @IBOutlet weak var alturaLabel: UILabel!
    
    @IBOutlet weak var herancaLabel: UILabel!
    
    var pokemon: PokemonView?
    var evolutionChain: EvolutionChainView?
    
    var specieService: SpecieService!
    var evolucaoService: EvolucaoService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configScreen()
        self.configService()
    }
    
    private func configService() {
        
        self.specieService = SpecieService(delegate: self)
        self.evolucaoService = EvolucaoService(delegate: self)
        
        if let pokemon = self.pokemon {
            self.specieService.getSpecie(id: pokemon.id)
        }
    }
    
    private func configScreen() {
        if let pokemon = self.pokemon {
            
            self.title = pokemon.name
            
            self.imagePokemonImageView.setImage(with: pokemon.image)
            
            self.hplabel.text = String(pokemon.status[5].baseStat)
            self.speedLabel.text = String(pokemon.status[0].baseStat)
            self.atackLabel.text = String(pokemon.status[4].baseStat)
            self.defenseLabel.text = String(pokemon.status[3].baseStat)
            self.spAtackLabel.text = String(pokemon.status[2].baseStat)
            self.spDefLabel.text = String(pokemon.status[1].baseStat)
            
            for index in 0 ..< pokemon.ability.count {
                self.abilidadesLabel.text! += ( (index + 1) == pokemon.ability.count ) ? "\(pokemon.ability[index].name)" : "\(pokemon.ability[index].name), "
            }
            
            self.comprimentoLabel.text = String(pokemon.weight)
            self.alturaLabel.text = String(pokemon.height)
        }
        
        self.configView()
    }
    
    private func configView(){
        
        self.info2View.layer.cornerRadius = 15
        self.info2View.layer.borderWidth = 2
        self.info2View.layer.borderColor = UIColor.black.cgColor
        
        self.info2View.layer.shadowColor = UIColor.green.cgColor
        self.info2View.layer.shadowOpacity = 1
        self.info2View.layer.shadowOffset = .zero
        self.info2View.layer.shadowRadius = 10
        
    }
}

extension DetalhesViewController: SpecieServiceDelegate {
    func success() {
        
        self.pokemon = PokemonViewModel.getPokemonView(id: pokemon!.name)

        if let pokemon = self.pokemon {
            self.evolucaoService.getEvolucao(id: pokemon.evolutionChainId)
        }
    }
    
    func failure(erro: String) {
        
    }
    
    
}
extension DetalhesViewController: EvolucaoServiceDelegate {
    func successEvolution() {
        if let pokemon = self.pokemon {
            self.evolutionChain = EvolutionChainViewModel.getEvolutionChain(id: pokemon.evolutionChainId)
        }
        
    }
    
    func failureEvolution(erro: String) {
        
    }
    
}
