//
//  AppDelegate.swift
//  pokeDex
//
//  Created by akiracaio on 20/11/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import UIKit
import RealmSwift

var baseUrl: String = "https://pokeapi.co/api/v2/"

var uiRealm: Realm!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            
            try uiRealm = Realm()
            
        } catch  {
            
            print("Erro no Realm")
        }
        
        print("DOCUMENTS: ", Realm.Configuration.defaultConfiguration.fileURL ?? "")
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

