//
//  AbilityViewModel.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import RealmSwift

struct AbilityView {
    
    var name: String = ""
}

class AbilityViewModel {
    static func save(object: Ability){
        try? uiRealm.write {
            uiRealm.add(object, update: .all)
        }
    }
    
    static func clear() {
        try? uiRealm.write{
            uiRealm.delete(uiRealm.objects(Ability.self))
        }
    }
    
    static func saveAll(objects: [Ability]) {
        try? uiRealm.write {
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func getAsView(ability: Ability?) -> AbilityView{
        
        guard let ability = ability else{
            return AbilityView()
        }

        var abilityView = AbilityView()
        
        abilityView.name = ability.name ?? "-"

        return abilityView
    }

    static func getAsView(abilitys: [Ability]) -> [AbilityView] {

        var abilitysView: [AbilityView] = []

        abilitys.forEach { (ability) in
            abilitysView.append(self.getAsView(ability: ability))
        }

        return abilitysView
    }

    static func getAsView(abilitys: List<Ability>) -> [AbilityView] {

        var abilitysView: [AbilityView] = []

        abilitys.forEach { (ability) in
            abilitysView.append(self.getAsView(ability: ability))
        }

        return abilitysView
    }
    
}

