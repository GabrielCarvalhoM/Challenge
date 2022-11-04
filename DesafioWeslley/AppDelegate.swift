//
//  AppDelegate.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 31/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        guard !UserDefaults.standard.bool(forKey: "logSwitch") else { return }
        let keyC = KeychainManager()
        try? keyC.deleteToken(identifier: "accessToken")
    }
    
}

