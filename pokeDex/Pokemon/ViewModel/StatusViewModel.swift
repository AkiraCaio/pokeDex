//
//  StatusViewModel.swift
//  pokeDex
//
//  Created by akiracaio on 28/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation
import RealmSwift

struct StatusView {
    
    var name: StatusEnum = .HP
    var baseStat: Int = 0
}

enum StatusEnum: String {
    case SPD
    case SDEF
    case SATK
    case DEF
    case ATK
    case HP
}

class StatusViewModel {
    
    static func save(object: Status){
        try? uiRealm.write {
            uiRealm.add(object, update: .all)
        }
    }
    
    static func clear() {
        try? uiRealm.write{
            uiRealm.delete(uiRealm.objects(Status.self))
        }
    }
    
    static func saveAll(objects: [Status]) {
        try? uiRealm.write {
            uiRealm.add(objects, update: .all)
        }
    }
    
    static func getAsView(status: Status?) -> StatusView{
        
        guard let status = status else{
            return StatusView()
        }

        var statusView = StatusView()
        
        statusView.name = self.getStatusEnum(name: status.name!)
        statusView.baseStat = status.baseStat.value ?? 0

        return statusView
    }

    static func getAsView(statusArray: [Status]) -> [StatusView] {

        var statusViewArray: [StatusView] = []

        statusArray.forEach { (status) in
            statusViewArray.append(self.getAsView(status: status))
        }

        return statusViewArray
    }

    static func getAsView(statusArray: List<Status>) -> [StatusView] {

        var statusViewArray: [StatusView] = []

        statusArray.forEach { (status) in
            statusViewArray.append(self.getAsView(status: status))
        }

        return statusViewArray
    }
    
    static private func getStatusEnum (name: String) -> StatusEnum {
        switch name {
        case "speed":
            return StatusEnum.SPD
        case "special-defense":
            return StatusEnum.SDEF
        case "special-attack":
            return StatusEnum.SATK
        case "defense":
            return StatusEnum.DEF
        case "attack":
            return StatusEnum.ATK
        case "hp":
            return StatusEnum.HP
        default:
            return StatusEnum.HP
        }
    }
    
    static func getBaseStatusString(number: Int) -> String {
        if (number >= 100){
            return "\(number)"
        }else if (number >= 10){
            return "0\(number)"
        }else{
            return "00\(number)"
        }
    }
}
