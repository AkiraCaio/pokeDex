//
//  TypesViewModel.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import RealmSwift

struct TypeView {
    
    var name: String = ""
}

class TypeViewModel {
    
    static func save(object: Type){
        try? uiRealm.write {
            uiRealm.add(object, update: .all)
        }
    }
    
    static func clear() {
        try? uiRealm.write{
            uiRealm.delete(uiRealm.objects(Type.self))
        }
    }
    
    static func saveAll(objects: [Type]) {
        try? uiRealm.write {
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func getAsView(type: Type?) -> TypeView{
        
        guard let type = type else{
            return TypeView()
        }

        var typeView = TypeView()
        
        typeView.name = type.name ?? "-"

        return typeView
    }

    static func getAsView(types: [Type]) -> [TypeView] {

        var typesView: [TypeView] = []

        types.forEach { (type) in
            typesView.append(self.getAsView(type: type))
        }

        return typesView
    }

    static func getAsView(types: List<Type>) -> [TypeView] {

        var typesView: [TypeView] = []

        types.forEach { (type) in
            typesView.append(self.getAsView(type: type))
        }

        return typesView
    }
    
}
