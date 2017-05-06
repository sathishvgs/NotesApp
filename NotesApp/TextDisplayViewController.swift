//
//  TextDisplayViewController.swift
//  NotesApp
//
//  Created by user on 5/5/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit

class TextDisplayViewController: UIViewController{

    @IBOutlet weak var textFieldLabel: UILabel!
    
    @IBOutlet weak var textViewContent: UITextView!
    
    var textTitle : String = ""
    var textView : [String: String] = [:]
    var text: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        textFieldLabel.text = textTitle
        self.navigationItem.title = "Notes"
        self.navigationController?.view.backgroundColor = UIColor.white
    }
        

    override func viewDidAppear(_ animated: Bool) {
       
        let userDefaults = UserDefaults()
        
        if let dictionary = userDefaults.dictionary(forKey: "UserNotes"){
            if let dictionaryTexts = dictionary as? [String : String] {
                textView = (dictionaryTexts)
               self.setTextViewValue()
            }
        }
    }
    

    func setTextViewValue(){
        
        for (key,value) in textView{
            if key == textTitle{
                textViewContent.text = value
                print("The key \(key) and Value \(value)")
            }
        }
    }
    
        
    func setNavigationBar(){
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        let navItem = UINavigationItem(title: "Notes")
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }

}
