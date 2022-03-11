//
//  AppDelegate.swift
//  List Post
//
//  Created by Jan Sebastian on 07/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        let homeVC = HomeViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.navigationBar.barTintColor = .white
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        
        return true
    }

    

}

