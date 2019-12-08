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
    case electric
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
    case rock
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
    
    static func getColorType(_ type: TypeEnum) -> UIColor{
        switch type {
            
        case .bug:
            return Colors.hexStringToUIColor(hex: "#92BC2C")
        case .dark:
            return Colors.hexStringToUIColor(hex: "#595761")
        case .dragon:
            return Colors.hexStringToUIColor(hex: "#0C69C8")
        case .electric:
            return Colors.hexStringToUIColor(hex: "#EDD53E")
        case .fairy:
            return Colors.hexStringToUIColor(hex: "#EC8CE5")
        case .fighting:
            return Colors.hexStringToUIColor(hex: "#CE4265")
        case .fire:
            return Colors.hexStringToUIColor(hex: "#FB9B51")
        case .flying:
            return Colors.hexStringToUIColor(hex: "#90A7DA")
        case .ghost:
            return Colors.hexStringToUIColor(hex: "#516AAC")
        case .grass:
            return Colors.hexStringToUIColor(hex: "#5FBC51")
        case .ground:
            return Colors.hexStringToUIColor(hex: "#DC7545")
        case .ice:
            return Colors.hexStringToUIColor(hex: "#70CCBD")
        case .normal:
            return Colors.hexStringToUIColor(hex: "#9298A4")
        case .poison:
            return Colors.hexStringToUIColor(hex: "#A864C7")
        case .psychic:
            return Colors.hexStringToUIColor(hex: "#F66F71")
        case .rock:
            return Colors.hexStringToUIColor(hex: "#C5B489")
        case .steel:
            return Colors.hexStringToUIColor(hex: "#52869D")
        case .water:
            return Colors.hexStringToUIColor(hex: "#559EDF")
        }
    }
    
    static func getImageType(_ type: TypeEnum) -> UIImage{
        
        switch type {
            
        case .bug:
            return UIImage(named: "Types-Bug")!
        case .dark:
            return UIImage(named: "Types-Dark")!
        case .dragon:
            return UIImage(named: "Types-Dragon")!
        case .electric:
            return UIImage(named: "Types-Electric")!
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
        case .rock:
            return UIImage(named: "Types-Rock")!
        case .steel:
            return UIImage(named: "Types-Steel")!
        case .water:
            return UIImage(named: "Types-Water")!
        }
        
    }
}
