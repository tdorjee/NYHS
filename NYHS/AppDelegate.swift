//
//  AppDelegate.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/3/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: MainViewController())
        self.window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        
//        window?.rootViewController = tabVC
        
//        let tabVC = UITabBarController()
//        
//        let home: HomeViewController = HomeViewController()
//        let map: MapViewController = MapViewController()
//        
//        let firstVC = UINavigationController(rootViewController: home)
//        let seconVC = UINavigationController(rootViewController: map)
//        
//        
//        
//        
//        let firstVCLable = UITabBarItem(title: "Home", image: nil, tag: 0)
//        let secondVCLable = UITabBarItem(title: "Map", image: nil, tag: 1)
//        
//        firstVC.tabBarItem = firstVCLable
//        seconVC.tabBarItem = secondVCLable
//
//        tabVC.viewControllers = [firstVC, seconVC]
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

