//
//  AppDelegate.swift
//  NotesApp
//
//  Created by user on 4/27/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit
import SwiftyDropbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        DropboxClientsManager.setupWithAppKey("mm354jjba4cg9hn")
    
        return true
    }
    
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let defaults = UserDefaults()

        

        
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            
            switch authResult {
                
            case .success(let token):
                
                print("The token is \(token)" )
                defaults.set("SUCCESS", forKey: "LoginSuccess")
            
                let client = DropboxClientsManager.authorizedClient
                
                client?.files.createFolder(path: "/Files").response { response, error in
                    
                NotificationCenter.default.post(name: Notification.Name(rawValue: "didLoggedInWithDropboxNotification"), object: nil)
                }
                
                
            case .cancel:
                break
                
            case .error(_, let description):
                print("Error: \(description)")
            }
        }
        return true
    }
}

