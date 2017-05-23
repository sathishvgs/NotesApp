//
//  SettingViewController.swift
//  NotesApp
//
//  Created by user on 5/20/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit
import SwiftyDropbox

class SettingViewController: UIViewController {
    
    
    let userDefaults = UserDefaults()
    
    @IBAction func LogOut(_ sender: Any) {
        
        DropboxClientsManager.unlinkClients()
        goToLogout()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationItem.title = "Setting"
        
        let sendButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(hide))
        
        self.tabBarController?.navigationItem.rightBarButtonItem = sendButton
    }
    
    
    func hide() {}
    

    func goToLogout() {
        
        DropboxClientsManager.unlinkClients()

        userDefaults.removeObject(forKey: "DropBoxFiles")
        userDefaults.removeObject(forKey: "UserNotes")
        userDefaults.removeObject(forKey: "LoginSuccess")
        
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let rootviewContoller = storyboard?.instantiateViewController(withIdentifier: "viewID") as? ViewController else{
            return
        }
        
        self.navigationController?.setViewControllers([rootviewContoller], animated: true)
    }
}
