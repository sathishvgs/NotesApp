//
//  NoteEditorViewController.swift
//  NotesApp
//
//  Created by user on 5/3/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit



class NoteEditorViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    let defaults = UserDefaults.standard
    var textDictionarys = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        textField.placeholder = "Enter your name of text"
        self.automaticallyAdjustsScrollViewInsets = true
    }
    
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        let navItem = UINavigationItem(title: "Editor")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(done))
        let closeItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(close))
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = closeItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func close() {
       
        self.dismiss(animated: true, completion: nil)
    }
    
    func done() {
        
        guard var textDictionary = defaults.dictionary(forKey: "UserNotes") as? [String : String] else{
            textDictionarys = [textField.text!:textView.text!]
            defaults.set(textDictionarys, forKey: "UserNotes")
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        if textField.text! == ""{
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        textDictionary[textField.text!] = textView.text!
        defaults.set(textDictionary, forKey: "UserNotes")
        self.dismiss(animated: true, completion: nil)
    }

}
