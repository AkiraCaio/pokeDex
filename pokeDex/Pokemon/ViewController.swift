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
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return tableView
    }()
    
    var viewFloatingButton: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .black
        
        view.layer.cornerRadius  = 25
                
        return view
    }()
    
    var floatingButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "topArrow"), for: .normal)
        button.addTarget(self, action: #selector(ViewController.showTopTableView), for: .touchDown)
        
        return button
    }()
    
    var favOnly: Bool = false
    var editMode: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.configService()
        self.setupTableView()
        self.configFloatingButton()
    }
    
    
    private func configFloatingButton() {
        
        self.view.addSubview(self.viewFloatingButton)
        
        NSLayoutConstraint.activate([
            self.viewFloatingButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -128),
            self.viewFloatingButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.viewFloatingButton.widthAnchor.constraint(equalToConstant: 50),
            self.viewFloatingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.view.bringSubviewToFront(self.viewFloatingButton)
        
        
        self.viewFloatingButton.addSubview(self.floatingButton)
        
        NSLayoutConstraint.activate([
            self.floatingButton.topAnchor.constraint(equalTo: self.viewFloatingButton.topAnchor, constant: 0),
            self.floatingButton.leftAnchor.constraint(equalTo: self.viewFloatingButton.leftAnchor, constant: 0),
            self.floatingButton.rightAnchor.constraint(equalTo: self.viewFloatingButton.rightAnchor, constant: 0),
            self.floatingButton.bottomAnchor.constraint(equalTo: self.viewFloatingButton.bottomAnchor, constant: 0),

        ])
        
        
    }
    private func configService() {
        self.service = PokemonService(delegate: self)
        
        self.service.getPokemons(number: 0)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        self.tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
        
        self.view.addSubview(self.tableView)
        
        self.tableView.separatorStyle = .none

        NSLayoutConstraint.activate([
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
        
    }
    
    @objc private func showTopTableView() {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as! PokemonTableViewCell
        
        cell.delegate = self
        cell.bind(pokemon: self.pokemons[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (!self.favOnly && !self.editMode) {
            if indexPath.row == self.pokemons.count - 1, !self.isFinished {
                
                self.service.getPokemons(number: self.pokemons.count)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = (storyboard?.instantiateViewController(identifier: "DetalhesViewController")) as! DetalhesViewController
        
        controller.pokemon = self.pokemons[indexPath.row]
        
        self.present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header =  HeaderTableView(frame: CGRect(x: 0, y: 0, width: 500, height: 90))
        
        header.delegate = self
        header.showFav = self.favOnly
                
        return header
    }
    
    
}

extension ViewController: PokemonServiceDelegate {
    func success() {
        
    }
    
    func success(isFinished: Bool) {
        
        if(!self.favOnly && !self.editMode) {
            self.isFinished = isFinished
            
            self.qtdLoadedPokemons += 1
            
            if qtdLoadedPokemons == 20 {
                self.pokemons = PokemonViewModel.getAll()
                
                self.tableView.reloadData()
                
                self.qtdLoadedPokemons = 0
            }
        }
        
    }
    
    func failure(erro: String) {
        print(erro)
        self.pokemons = PokemonViewModel.getAll()
        
        self.tableView.reloadData()
    }
}

extension ViewController: PokemonTableViewCellDelegate {
    func atualizaFavPok(favorito: Bool, id: Int) {
        
        if(self.favOnly){
            self.pokemons = PokemonViewModel.getFav()
            self.tableView.reloadData()
        }else{
            
            let index = self.pokemons.firstIndex(where: {$0.id == id})!
            
            var newPokemon = self.pokemons[index]
            newPokemon.favorito = favorito
            
            self.pokemons.remove(at: index)
            
            self.pokemons.insert(newPokemon, at: index)
        }
    }
    
}

extension ViewController: HeaderTableViewDelegate {
    func filterPokm(text: String) {
        if text.isEmpty {
            self.editMode = false
            self.pokemons = self.favOnly ? PokemonViewModel.getFav() : PokemonViewModel.getAll()
        }else{
            self.editMode = true
            self.pokemons = self.favOnly ? PokemonViewModel.getFav().filter {$0.name.contains(text)} : PokemonViewModel.getAll().filter {$0.name.contains(text)}
        }
        
        self.tableView.reloadData()
    }
    
    func actionFav(fav: Bool) {
        
        self.pokemons = fav ? PokemonViewModel.getFav() : PokemonViewModel.getAll()
        self.favOnly = fav
        
        self.tableView.reloadData()
    }
    
    
}
