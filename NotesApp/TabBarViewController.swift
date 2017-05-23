//
//  TabBarViewController.swift
//  NotesApp
//
//  Created by user on 5/4/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit
import SwiftyDropbox

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        
    }
    
}
