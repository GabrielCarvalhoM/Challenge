//
//  SceneDelegate.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 31/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        
        logedCheck()
    }
    
    func logedCheck() {
        let keyC = KeychainManager()
        var controller: UIViewController
        
        
        if let _ = try? keyC.getToken(identifier: "accessToken") {
            controller = CarsListTableViewController()
            
        } else {
            controller = LoginViewController()
            
        }
        
        let navigation = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()

    }
    
}

  

