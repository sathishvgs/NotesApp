//
//  MyNavigaitonController.swift
//  NotesApp
//
//  Created by user on 5/2/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit

class MyNavigaitonController: UINavigationController {
    
    let defaults = UserDefaults()
    var userDatas:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        guard defaults.string(forKey: "LoginSuccess") == "SUCCESS" else{
            
            goToViewController()
            return
        }
        
        
        goToTabBarController()
    }
    
    func goToViewController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier:"viewID") as? ViewController else{
            return
        }
        
        self.setViewControllers([viewController], animated: true)
    }
    
    
    func goToTabBarController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewContoller = storyboard.instantiateViewController(withIdentifier: "TabId") as? TabBarViewController else{
            return
        }
        
        self.setViewControllers([viewContoller], animated: true)
    }
}
