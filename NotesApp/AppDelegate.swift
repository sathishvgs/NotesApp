//
//  AppDelegate.swift
//  NotesApp
//
//  Created by user on 4/27/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print(" Application Did Finish Launch")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        print("Application in Resign Active state")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        print(" Application in the Background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
        print(" Application in the Foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        print(" Application in Active ")
    }

    func applicationWillTerminate(_ application: UIApplication) {
    
        print(" Application Terminated ")
    }


}

