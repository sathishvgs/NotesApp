//
//  ViewController.swift
//  NotesApp
//
//  Created by user on 4/27/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   /* let list = ["Apple","Banana","Blue Berry","Grapes"]
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return list.count
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        return (cell)
    }*/
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(" View Loaded ")
    }

    override func viewWillAppear(_ animated: Bool) {
        
        print(" view about to Appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print(" view appeared")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print(" view about to Disppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print(" view Disappeared")
    }
}

