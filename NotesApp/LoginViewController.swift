//
//  ViewController.swift
//  NotesApp
//
//  Created by user on 4/27/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit
import SwiftyDropbox

class ViewController: UIViewController {
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        print("Login Action")
        
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.openURL(url)
        })
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
         NotificationCenter.default.addObserver(self, selector: #selector(self.didLoggedInWithDropbox), name: Notification.Name(rawValue: "didLoggedInWithDropboxNotification"), object: nil)
    }
    
    func goToNavigationController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewControllerLogin = storyboard.instantiateViewController(withIdentifier: "NavigationId") as? MyNavigaitonController  else {
            return
        }
         present(viewControllerLogin, animated: true, completion: nil)
    }
    
    
    func didLoggedInWithDropbox(){
            
        self.goToTabBarController()
    }
    
    
    func goToTabBarController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let tabBar = storyboard.instantiateViewController(withIdentifier: "TabId") as? TabBarViewController else{
            return
        }
        
        self.navigationController?.pushViewController(tabBar, animated: true)
    }
}

