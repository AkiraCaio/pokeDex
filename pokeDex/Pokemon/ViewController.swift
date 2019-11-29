//
//  ViewController.swift
//  pokeDex
//
//  Created by akiracaio on 20/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var service: PokemonService!
    
    var pokemons: [PokemonView] = []
    
    var isFinished = false
    
    var qtdLoadedPokemons = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configService()
        self.setupTableView()
    }
    
    private func configService() {
        self.service = PokemonService(delegate: self)
        
        self.service.getPokemons(number: 0)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as! PokemonTableViewCell
        
        cell.bind(pokemon: self.pokemons[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.pokemons.count - 1, !self.isFinished {
            
            self.service.getPokemons(number: self.pokemons.count)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = (storyboard?.instantiateViewController(identifier: "DetalhesViewController")) as! DetalhesViewController
        
        controller.pokemon = self.pokemons[indexPath.row]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController: PokemonServiceDelegate {
    func success() {
        
    }
    
    func success(isFinished: Bool) {
        
        self.isFinished = isFinished
        
        self.qtdLoadedPokemons += 1
        
        if qtdLoadedPokemons == 20 {
            self.pokemons = PokemonViewModel.getAll()
            
            self.tableView.reloadData()
            
            self.qtdLoadedPokemons = 0
        }
    }
    
    func failure(erro: String) {
        print(erro)
        self.pokemons = PokemonViewModel.getAll()
        
        self.tableView.reloadData()
    }
    
    
}
