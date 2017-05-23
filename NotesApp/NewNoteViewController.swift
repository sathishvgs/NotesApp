//
//  NoteEditorViewController.swift
//  NotesApp
//
//  Created by user on 5/3/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit
import SwiftyDropbox

protocol NotesviewDelegate: class {
    
    func didDoneButtonPressed()
}


class NoteEditorViewController: UIViewController {
    
    let userDefault = UserDefaults()
    var isValid: String = ""
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let client = DropboxClientsManager.authorizedClient
    

    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    let defaults = UserDefaults.standard
    var textDictionarys = [String: String]()
    
    weak var delegate: NotesviewDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setNavigationBar()
        textField.placeholder = "Enter the name of text"
        self.automaticallyAdjustsScrollViewInsets = true
    }
    
    
    func setNavigationBar() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        let navItem = UINavigationItem(title: "Editor")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(save))
        let closeItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(close))
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = closeItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    
    func close() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func save() {
        
        if textField.text! != "" {
            
            
            if var dictionary = userDefault.dictionary(forKey: "UserNotes"){
                
                dictionary[textField.text!] = textView.text!
                userDefault.set(dictionary, forKey: "UserNotes")
                print("The Upload process \(dictionary)")
                
            }else {
                
                let dictionary = [textField.text! : textView.text!]
                userDefault.set(dictionary, forKey: "UserNotes")
            }
            
        }else {
            
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        saveFileInDropbox()
    }
    
    
    func saveFileInDropbox() {
        
        guard let textTitle : String = textField.text else{
            return
        }
        
        
        if var file = userDefault.object(forKey: "DropBoxFiles") as? [String]{
            
            file.append(textTitle)
            print("The File is \(file)")
            userDefault.set(file, forKey: "DropBoxFiles")
            
        }else{
            
            userDefault.set(textTitle, forKey:"DropBoxFiles")
        }
        
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "invokeActivityIndicator"), object: nil)
        
        let Description = textView.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        
        _ = self.client?.files.upload(path: "/Files/\(textTitle).txt", input: Description).response { response, error in
            
            if let response = response {
                
                print("The upload response is \(response)")
                
            } else if let error = error {
                
                print("The upload error is \(error)")
            }
            
           // self.activityIndicator.stopAnimating()
            }
            .progress { progressData in
                
                print("The progress Data is \(progressData)")
        }
        
        print(" Notes Editor View Loaded ")
        self.dismiss(animated: true, completion: nil)
    }
}


