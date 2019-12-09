//
//  DetalhesViewController.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    
    var pokemon: PokemonView?
    var evolutionChain: EvolutionChainView?
    
    var pokemonService: PokemonService!
    var specieService: SpecieService!
    var evolucaoService: EvolucaoService!
    
    let pokemonView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let pokemonInfoView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let pokemonLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textAlignment = .center
        
        lbl.font = UIFont(name: "Avenir-Book", size: 40)!
        
        
        return lbl
    }()
    
    let pokemonTypeImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let pokemonSegmentController: UISegmentedControl = {
        let control = UISegmentedControl(items: ["STATS", "EVOLUTIONS"])
        
        control.translatesAutoresizingMaskIntoConstraints = false
        
        control.selectedSegmentIndex = 0
        
        return control
    }()
    
    let pokemonStatusView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var pokemonStatusViews: [UIView] = []
    
    var pokemonEvolutionView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        

        view.alwaysBounceVertical = true
        view.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        
        view.isHidden = true
        
        return view
    }()
    
    var pokemonEvolutionViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.configScreen()
        self.configService()
    }
    
    private func configService() {
        
        self.specieService = SpecieService(delegate: self)
        self.evolucaoService = EvolucaoService(delegate: self)
        self.pokemonService = PokemonService(delegate: self)
        
        if let pokemon = self.pokemon {
            self.specieService.getSpecie(id: pokemon.id)
        }
    }
    
    
    private func configScreen() {
        
        if let pokemon = self.pokemon {
            self.title = pokemon.name.firstUppercased
            
            self.view.backgroundColor = TypeViewModel.getColorType(pokemon.types)
            
            self.configPokemonView(image: pokemon.image)
            self.configPokemonInfoView()
            self.configPokemonLabel(name: pokemon.name.firstUppercased)
            self.configTypeImageView(types: pokemon.types)
            self.configPokemonSegmentController(types: pokemon.types)
            self.configPokemonStatusView(pokemonStatus: pokemon.status)
            
            
            self.pokemonInfoView.addSubview(self.pokemonEvolutionView)
                        
            NSLayoutConstraint.activate([
                self.pokemonEvolutionView.leftAnchor.constraint(equalTo: self.pokemonInfoView.leftAnchor, constant: 16),
                self.pokemonEvolutionView.rightAnchor.constraint(equalTo: self.pokemonInfoView.rightAnchor, constant: -16),
                self.pokemonEvolutionView.topAnchor.constraint(equalTo: self.pokemonSegmentController.bottomAnchor, constant: 16),
                self.pokemonEvolutionView.bottomAnchor.constraint(equalTo: self.pokemonInfoView.bottomAnchor, constant: -32)
            ])
            
            
        }
    }
    
    //TODO: Atualizar o modelo para pegar as informacoes de level
    private func addPokemonEvolutionToScreen(pokemonBase: PokemonView, pokemonEvolution: PokemonView, level: Int){
        
        let viewInterna = UIView()
        
        viewInterna.translatesAutoresizingMaskIntoConstraints = false
        
        self.pokemonEvolutionView.addSubview(viewInterna)
        
        if (self.pokemonEvolutionViews.isEmpty){
            
            NSLayoutConstraint.activate([
                viewInterna.leftAnchor.constraint(equalTo: self.pokemonEvolutionView.leftAnchor),
                viewInterna.rightAnchor.constraint(equalTo: self.pokemonEvolutionView.rightAnchor),
                viewInterna.topAnchor.constraint(equalTo: self.pokemonEvolutionView.topAnchor),
                viewInterna.heightAnchor.constraint(equalToConstant: 80)
            ])
            
        } else {
            
            NSLayoutConstraint.activate([
                viewInterna.leftAnchor.constraint(equalTo: self.pokemonEvolutionView.leftAnchor),
                viewInterna.leftAnchor.constraint(equalTo: self.pokemonEvolutionView.leftAnchor),
                viewInterna.heightAnchor.constraint(equalToConstant: 80),
                viewInterna.topAnchor.constraint(equalTo: self.pokemonEvolutionViews.last!.bottomAnchor),
            ])
        }
        
        self.pokemonEvolutionViews.append(viewInterna)
        
        let imagePokBase = UIImageView(image: UIImage())
        imagePokBase.setImage(with: pokemonBase.image)
        
        imagePokBase.translatesAutoresizingMaskIntoConstraints = false
        
        viewInterna.addSubview(imagePokBase)
        
        NSLayoutConstraint.activate([
            imagePokBase.leftAnchor.constraint(equalTo: viewInterna.leftAnchor),
            imagePokBase.topAnchor.constraint(equalTo: viewInterna.topAnchor),
            imagePokBase.widthAnchor.constraint(equalToConstant: 80),
            imagePokBase.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let imagePokEvoluiTo = UIImageView(image: UIImage())
        imagePokEvoluiTo.setImage(with: pokemonEvolution.image)

        imagePokEvoluiTo.translatesAutoresizingMaskIntoConstraints = false
        
        viewInterna.addSubview(imagePokEvoluiTo)
        
        NSLayoutConstraint.activate([
            imagePokEvoluiTo.leftAnchor.constraint(equalTo: imagePokBase.rightAnchor, constant: 16),
            imagePokEvoluiTo.topAnchor.constraint(equalTo: viewInterna.topAnchor),
            imagePokEvoluiTo.widthAnchor.constraint(equalToConstant: 80),
            imagePokEvoluiTo.heightAnchor.constraint(equalToConstant: 80)
        ])
        
    }
    
    private func configPokemonStatusView(pokemonStatus: [StatusView]) {
        self.pokemonInfoView.addSubview(self.pokemonStatusView)
        
        NSLayoutConstraint.activate([
            self.pokemonStatusView.topAnchor.constraint(equalTo: self.pokemonSegmentController.bottomAnchor, constant: 32),
            self.pokemonStatusView.leftAnchor.constraint(equalTo: self.pokemonInfoView.leftAnchor, constant: 16),
            self.pokemonStatusView.rightAnchor.constraint(equalTo: self.pokemonInfoView.rightAnchor, constant: -16),
            self.pokemonStatusView.bottomAnchor.constraint(equalTo: self.pokemonInfoView.bottomAnchor),
        ])
        
        
        for status in pokemonStatus{
            self.createStatusInfoView(statusName: status.name.rawValue, statusValue: StatusViewModel.getBaseStatusString(number: status.baseStat))
        }
    }
    
    private func createStatusInfoView(statusName: String, statusValue: String) {
        
        let viewInterna = UIView()
        
        viewInterna.translatesAutoresizingMaskIntoConstraints = false
        
        self.pokemonStatusView.addSubview(viewInterna)
        
        if (self.pokemonStatusViews.isEmpty){
            
            NSLayoutConstraint.activate([
                viewInterna.leftAnchor.constraint(equalTo: self.pokemonStatusView.leftAnchor),
                viewInterna.rightAnchor.constraint(equalTo: self.pokemonStatusView.rightAnchor),
                viewInterna.topAnchor.constraint(equalTo: self.pokemonStatusView.topAnchor),
                viewInterna.heightAnchor.constraint(equalToConstant: 32)
            ])
            
        } else {
            NSLayoutConstraint.activate([
                viewInterna.leftAnchor.constraint(equalTo: self.pokemonStatusView.leftAnchor),
                viewInterna.rightAnchor.constraint(equalTo: self.pokemonStatusView.rightAnchor),
                viewInterna.heightAnchor.constraint(equalToConstant: 32),
                viewInterna.topAnchor.constraint(equalTo: self.pokemonStatusViews.last!.bottomAnchor),
            ])
        }
        
        self.pokemonStatusViews.append(viewInterna)
        
        let lblName = UILabel()
        lblName.text = statusName
        lblName.textColor = .blue
        
        lblName.translatesAutoresizingMaskIntoConstraints = false
        
        viewInterna.addSubview(lblName)
        
        NSLayoutConstraint.activate([
            lblName.leftAnchor.constraint(equalTo: viewInterna.leftAnchor),
            lblName.topAnchor.constraint(equalTo: viewInterna.topAnchor),
            lblName.bottomAnchor.constraint(equalTo: viewInterna.bottomAnchor),
            lblName.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        
        let lblStatusValue = UILabel()
        
        lblStatusValue.translatesAutoresizingMaskIntoConstraints = false
        lblStatusValue.text = statusValue
        
        viewInterna.addSubview(lblStatusValue)
        
        NSLayoutConstraint.activate([
            lblStatusValue.centerYAnchor.constraint(equalTo: lblName.centerYAnchor),
            lblStatusValue.leftAnchor.constraint(equalTo: lblName.rightAnchor, constant: 16)
        ])
        
    }
    
    
    private func configPokemonSegmentController(types: [TypeView]) {
        
        self.pokemonInfoView.addSubview(self.pokemonSegmentController)
        
        NSLayoutConstraint.activate([
            self.pokemonSegmentController.topAnchor.constraint(equalTo: self.pokemonTypeImageView.bottomAnchor, constant: 16),
            self.pokemonSegmentController.leftAnchor.constraint(equalTo: self.pokemonInfoView.leftAnchor, constant: 16),
            self.pokemonSegmentController.rightAnchor.constraint(equalTo: self.pokemonInfoView.rightAnchor, constant: -16),
            self.pokemonSegmentController.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        self.pokemonSegmentController.addTarget(self, action: #selector(DetalhesViewController.indexChanged(_:)), for: .valueChanged)
        
        self.pokemonSegmentController.selectedSegmentTintColor = TypeViewModel.getColorType(types)
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        
    }
    
    @objc private func indexChanged(_ sender: UISegmentedControl) {
        if self.pokemonSegmentController.selectedSegmentIndex == 0 {
            print("Select 0")
            self.pokemonStatusView.isHidden = false
            self.pokemonEvolutionView.isHidden = true
            
        } else {
            //TODO: EXIBIR A view que possuie as evolucoes
            self.pokemonStatusView.isHidden = true
            self.pokemonEvolutionView.isHidden = false
            
            
            print("Select 1")
        }
    }
    
    private func configTypeImageView(types: [TypeView]) {
        if (types.count == 1){
            
            self.pokemonTypeImageView.image = TypeViewModel.getImageTag(types[0].name)
            
            self.pokemonInfoView.addSubview(self.pokemonTypeImageView)
            
            NSLayoutConstraint.activate([
                self.pokemonTypeImageView.topAnchor.constraint(equalTo: self.pokemonLabel.bottomAnchor),
                self.pokemonTypeImageView.centerXAnchor.constraint(equalTo: self.pokemonInfoView.centerXAnchor)
            ])
            
            
        }else{
            
            self.pokemonTypeImageView.image = TypeViewModel.getImageTag(types[1].name)
            
            self.pokemonInfoView.addSubview(self.pokemonTypeImageView)
            
            NSLayoutConstraint.activate([
                self.pokemonTypeImageView.topAnchor.constraint(equalTo: self.pokemonLabel.bottomAnchor),
                self.pokemonTypeImageView.centerXAnchor.constraint(equalTo: self.pokemonInfoView.centerXAnchor, constant: -64)
            ])
            
            let type2ImageVIew = UIImageView(image: TypeViewModel.getImageTag(types[0].name))
            
            type2ImageVIew.translatesAutoresizingMaskIntoConstraints = false
            
            self.pokemonInfoView.addSubview(type2ImageVIew)
            
            NSLayoutConstraint.activate([
                type2ImageVIew.centerYAnchor.constraint(equalTo: self.pokemonTypeImageView.centerYAnchor),
                type2ImageVIew.leftAnchor.constraint(equalTo: self.pokemonTypeImageView.rightAnchor, constant: 8)
            ])
            
            
        }
    }
    
    private func configPokemonView(image: String) {
        
        self.view.addSubview(self.pokemonView)
        
        NSLayoutConstraint.activate([
            self.pokemonView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            self.pokemonView.heightAnchor.constraint(equalToConstant: 180),
            self.pokemonView.widthAnchor.constraint(equalToConstant: 180),
            self.pokemonView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.pokemonView.setImage(with: image)
        
    }
    
    private func configPokemonInfoView() {
        self.view.addSubview(self.pokemonInfoView)
        
        NSLayoutConstraint.activate([
            self.pokemonInfoView.topAnchor.constraint(equalTo: self.pokemonView.bottomAnchor, constant: -72),
            self.pokemonInfoView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.pokemonInfoView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.pokemonInfoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        //Traz para frente o pokemon em relacao a viewdas informacoes
        self.view.bringSubviewToFront(self.pokemonView)
    }
    
    private func configPokemonLabel(name: String) {
        
        self.pokemonInfoView.addSubview(self.pokemonLabel)
        
        NSLayoutConstraint.activate([
            self.pokemonLabel.topAnchor.constraint(equalTo: self.pokemonView.bottomAnchor, constant: -16),
            self.pokemonLabel.leftAnchor.constraint(equalTo: self.pokemonInfoView.leftAnchor,constant:  8),
            self.pokemonLabel.rightAnchor.constraint(equalTo: self.pokemonInfoView.rightAnchor, constant: -8)
        ])
        
        self.pokemonLabel.text = name
    }
    
    
    
}

extension DetalhesViewController: SpecieServiceDelegate {
    func sucessSpecie() {
        
        self.pokemon = PokemonViewModel.getPokemonView(id: pokemon!.name)
        
        if let pokemon = self.pokemon {
            self.evolucaoService.getEvolucao(id: pokemon.evolutionChainId)
        }
    }
    
    func failureSpecie(erro: String) {
        
    }
    
    
}

extension DetalhesViewController: EvolucaoServiceDelegate {
    func successEvolution() {
        if let pokemon = self.pokemon {
            self.evolutionChain = EvolutionChainViewModel.getEvolutionChain(id: pokemon.evolutionChainId)
            
            let pokEvoList = EvolutionChainViewModel.getEvolutionPokemon(evolutionChain: self.evolutionChain!)
            
            for pokemonEvolution in pokEvoList {
                self.addPokemonEvolutionToScreen(pokemonBase: pokemonEvolution[0], pokemonEvolution: pokemonEvolution[1], level: 0)
            }

            
             
            
            
            
        }
        
    }
    
    func failureEvolution(erro: String) {
        
    }
    
}

extension DetalhesViewController: PokemonServiceDelegate {
    func success(isFinished: Bool) {
        
    }
    
    func success() {
        
    }
    
    func failure(erro: String) {
        
    }
    
    
}
