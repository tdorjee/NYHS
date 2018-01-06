//
//  AppDelegate.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/3/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyDDQoigYktTRrieAf8-J3ZJJeBgB-MkLI8")
        GMSPlacesClient.provideAPIKey("AIzaSyAKy5znlGQfMUm1UkPh_l_bSu0HDBcsnfc")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        self.window?.rootViewController = MainTabVC()
        
        return true
    }
    
    class func sharedInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
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

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

// MARK: Core data stuffs

/*
 lazy var persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: "FavSchool")
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 if let error = error as NSError? {
 fatalError("Unresolved error: \(error)")
 }
 })
 return container
 }()
 
 func saveContext() {
 let context = persistentContainer.viewContext
 if context.hasChanges {
 do {
 try context.save()
 } catch {
 print("Error")
 }
 }
 }
 
 
 

 */
