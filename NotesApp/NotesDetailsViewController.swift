//
//  TextDisplayViewController.swift
//  NotesApp
//
//  Created by user on 5/5/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit
import SwiftyDropbox

class TextDisplayViewController: UIViewController{
    
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textViewContent: UITextView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var textTitle : String = ""
    var textDescription : String = ""
    var textKey: [String] = [""]
    var textFile : [String: String] = [:]
    var text: String = ""

    var client = DropboxClientsManager.authorizedClient
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldLabel.text = textTitle
        self.navigationItem.title = "Notes"
        
        let editButton = UIBarButtonItem(title: "save",style: .plain, target: self, action: #selector(saveEditFiles))
        self.navigationItem.rightBarButtonItem = editButton

        self.navigationController?.view.backgroundColor = UIColor.white
        
        //NotificationCenter.default.addObserver(self, selector: #selector(self.invokeActivityIndicator), name: Notification.Name(rawValue: "invokeActivityIndicator"), object: nil)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("Text Display view controller")
        
        setTextViewValue()
    }
    
    
    func setTextViewValue() {
        
        
        let userDefaults = UserDefaults()
        
        if let dictionary = userDefaults.dictionary(forKey: "UserNotes"){
            
            if let dictionaryTexts = dictionary as? [String : String] {
                
                textFile = dictionaryTexts
                textKey = [String](dictionaryTexts.keys)
                print("The text File is  \(dictionaryTexts) \(dictionary)")
            }
        }
        
        if textKey.contains(textTitle){
            
            self.textViewContent.text = textFile[textTitle]
            print("The print file is \(self.textViewContent.text)")
        }else {
            
            let path = "/Files/\(textTitle).txt"
            
            invokeActivityIndicator()
            
          _ =  client?.files.download(path: path).response{response,error in
                
                if let response = response{
                    let responseMetadata = response.0
                    print("The Download reponse \(responseMetadata)")
                    let filecontents = response.1
                    let description = String(data: filecontents, encoding: String.Encoding.utf8)!
                    self.textViewContent.text = description
                    print("The Download response.1 is \(String(data: filecontents, encoding: String.Encoding.utf8)!)")
                }else if let error = error{
                    print("The Download error is \(error)")
                }
            self.view.isUserInteractionEnabled = true
            self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    
    
     func invokeActivityIndicator() {
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func setNavigationBar(){
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        let navItem = UINavigationItem(title: "Notes")
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func saveEditFiles(){
        
        
        let path = "/Files/\(textTitle).txt"
        
        invokeActivityIndicator()
        
        let Description = textViewContent.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        
         _ = client?.files.upload(path: path, mode: .overwrite, autorename: false, clientModified: nil, mute: false, input: Description).response { response, error in
        
            if let response = response {
                
                print("The upload response is \(response)")
                
            } else if let error = error {
                
                print("The upload error is \(error)")
            }
            
            self.dismiss(animated: false, completion: nil)
        
            }
            .progress { progressData in
                
                print("The progress Data is \(progressData)")
        }
        
        navigationController?.popViewController(animated: true)
    }
}


