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
    
    var name: String = ""
    var baseStat: Int = 0
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
        
        statusView.name = status.name ?? "-"
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
    
}
