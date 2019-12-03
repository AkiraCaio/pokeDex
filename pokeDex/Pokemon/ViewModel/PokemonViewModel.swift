//
//  PokemonViewModel.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import RealmSwift

struct PokemonView {
    
    var height: Float = 0
    var id: Int = 0
    var weight: Float = 0
    var name: String = ""
    var image: String = ""
    var favorito: Bool = false
    var ability: [AbilityView] = []
    var types: [TypeView] = []
    var status: [StatusView] = []
    var evolutionChainId: Int = -1
}

class PokemonViewModel {
    
    static func save(object: Pokemon){
        try? uiRealm.write {
            uiRealm.add(object, update: .all)
        }
    }
    
    static func save(nomePokemon: String, idEvolutionChain: Int) {
        let results = self.get(by: nomePokemon)
        
        if let pokemon = results {
            
            try? uiRealm.write {
                pokemon.evolucaoPokemon.value = idEvolutionChain
                
                uiRealm.add(pokemon, update: .all)
            }
        }
    }
        
    static func clear() {
        try? uiRealm.write{
            uiRealm.delete(uiRealm.objects(Pokemon.self))
        }
    }
    static func saveAll(objects: [Pokemon]) {
        try? uiRealm.write {
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func deletePost(id: Int){
        if let result = uiRealm.object(ofType: Pokemon.self, forPrimaryKey: id){
            try? uiRealm.write {
                uiRealm.delete(result)
            }
        }
    }
    
    static func get(by id: String) -> Pokemon? {
        
        let results = uiRealm.object(ofType: Pokemon.self, forPrimaryKey: id)
        
        return results
    }
    
    static func getPokemonView(id: String) -> PokemonView{
        
        let result = uiRealm.object(ofType: Pokemon.self, forPrimaryKey: id)
        
        return self.getAsView(pokemon: result)
    }
    
    
    static func getAsView(pokemon: Pokemon?) -> PokemonView{
        guard let pokemon = pokemon else{
            return PokemonView()
        }
        
        var pokemonView = PokemonView()
        
        pokemonView.height = pokemon.height.value ?? 0
        pokemonView.id = pokemon.id.value ?? 0
        pokemonView.weight = pokemon.weight.value ?? 0
        pokemonView.name = pokemon.name ?? "pika"
        pokemonView.image = pokemon.sprites ?? "-"
        pokemonView.ability = AbilityViewModel.getAsView(abilitys: pokemon.abilities)
        pokemonView.types = TypeViewModel.getAsView(types: pokemon.types)
        pokemonView.status = StatusViewModel.getAsView(statusArray: pokemon.status)
        pokemonView.favorito = pokemon.favorito
        pokemonView.evolutionChainId = pokemon.evolucaoPokemon.value ?? -1
        
        return pokemonView
    }
    
    static func getAsView(pokemons: [Pokemon]) -> [PokemonView] {
        
        var pokemonsView: [PokemonView] = []
        
        pokemons.forEach { (pokemon) in
            pokemonsView.append(self.getAsView(pokemon: pokemon))
        }
        
        return pokemonsView
    }
    
    static func getAsView(pokemons: List<Pokemon>) -> [PokemonView] {
        
        var pokemonsView: [PokemonView] = []
        
        pokemons.forEach { (pokemon) in
            pokemonsView.append(self.getAsView(pokemon: pokemon))
        }
        
        return pokemonsView
    }
    
    static func get() -> [Pokemon] {
        
        let results = uiRealm.objects(Pokemon.self)
        
        var posts: [Pokemon] = []
        posts.append(contentsOf: results)
        
        return posts
    }
    
    static func getAll() -> [PokemonView] {
        return self.getAsView(pokemons: self.get())
    }
    
    static func getIdEvolutionChain(url: String) -> Int {
        
        var componets = url.components(separatedBy: "/")
        return Int(componets[componets.count - 2]) ?? 0
    }
    
    //    static func getAsModel(postView: PostView) -> Post {
    //        let post = Post()
    //
    //        post.id.value = postView.id
    //        post.criado_em.value = postView.criado_em
    //        post.curtidas.value = postView.curtidas
    //        post.mensagem = postView.message
    //        post.author = postView.author
    //        post.curtido.value = postView.curtido
    //
    //        return post
    //    }
    //
    //
    
    
}
