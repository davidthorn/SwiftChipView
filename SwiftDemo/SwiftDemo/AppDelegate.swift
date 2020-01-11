//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by David Thorn on 12.01.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainController = ChipViewController<ChipViewModel>(layout: ChipViewFlowLayout())
        mainController.chipViewModels = [
            .init(title: "1....ee"),
            .init(title: "2...ee"),
            .init(title: "3....ee"),
            .init(title: "A reaaaallly long teeeeeeexxxxttt"),
        ]
        window?.rootViewController = mainController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
