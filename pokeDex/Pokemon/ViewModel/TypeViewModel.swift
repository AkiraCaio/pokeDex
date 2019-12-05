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
    
    var name: TypeEnum = .normal
}

enum TypeEnum: String {
    case bug
    case dark
    case dragon
    case eletric
    case fairy
    case fighting
    case fire
    case flying
    case ghost
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case steel
    case water
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
        
        typeView.name = TypeEnum(rawValue: type.name ?? "") ?? TypeEnum.normal
        
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
    
    static func getImageType(_ type: TypeEnum) -> UIImage{
        
        switch type {
            
        case .bug:
            return UIImage(named: "Types-Bug")!
        case .dark:
            return UIImage(named: "Types-Dark")!
        case .dragon:
            return UIImage(named: "Types-Dragon")!
        case .eletric:
            return UIImage(named: "Types-Eletric")!
        case .fairy:
            return UIImage(named: "Types-Fairy")!
        case .fighting:
            return UIImage(named: "Types-Fight")!
        case .fire:
            return UIImage(named: "Types-Fire")!
        case .flying:
            return UIImage(named: "Types-Flying")!
        case .ghost:
            return UIImage(named: "Types-Ghost")!
        case .grass:
            return UIImage(named: "Types-Grass")!
        case .ground:
            return UIImage(named: "Types-Ground")!
        case .ice:
            return UIImage(named: "Types-Ice")!
        case .normal:
            return UIImage(named: "Types-Normal")!
        case .poison:
            return UIImage(named: "Types-Poison")!
        case .psychic:
            return UIImage(named: "Types-Psychic")!
        case .steel:
            return UIImage(named: "Types-Steel")!
        case .water:
            return UIImage(named: "Types-Water")!
        }
        
    }
}
