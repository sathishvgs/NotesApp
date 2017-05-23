
//
//  NotesViewController.swift
//  NotesApp
//
//  Created by user on 5/4/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit

import SwiftyDropbox

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NotesviewDelegate {
    
    var listOfFileTitles: [String] = []
    var dropBoxFiles: [String] = []
    var storeUserFile: [String:String] = [:]
    let userDefaults = UserDefaults()
    var userFileList: [String] = []
    var accessToken: String = ""
    
    let client = DropboxClientsManager.authorizedClient
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
        self.listOfFilesFromDropbox()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "Notes"
        
        let sendButton = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(goToNoteEditorViewController))
        
        self.tabBarController?.navigationItem.rightBarButtonItem = sendButton
        //self.tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.fetchUserFile()
        self.tableView.reloadData()
    }
    
    
    func goToNoteEditorViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier:"NoteEditorViewID") as? NoteEditorViewController else{
            return
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return userFileList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = userFileList[indexPath.row]
        print("The cell is \(cell)")
        return (cell)
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let controller = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = controller.instantiateViewController(withIdentifier:"TextDisplayID") as? TextDisplayViewController else{
            return
        }
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRow(at: indexPath!)!
        
        let text = currentCell.textLabel!.text ?? ""
        print(currentCell.textLabel!.text ?? "")
        
        viewController.textTitle = text
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    
    func didDoneButtonPressed() {
        
        if let dictionary = userDefaults.dictionary(forKey: "UserNotes"){
            if let dictionaryText = dictionary as? [String : String] {
                listOfFileTitles = [String](dictionaryText.keys)
                
                for file in listOfFileTitles{
                    if !dropBoxFiles.contains(file) {
                        dropBoxFiles.append(file)
                    }
                }
                
                print("Done button Dropbox \(dropBoxFiles)")
                print("array values key : \(listOfFileTitles)")
            }
            self.tableView.reloadData()
        }
    }
    
    
    func fetchUserFile() {
        
        if let file = userDefaults.object(forKey: "DropBoxFiles") {
            
            if let files = file as? [String] {
                userFileList = files
                print("The user File is\(userFileList)")
                
            }else {
                
                if !userFileList.contains(file as! String){
                    
                    userFileList.append(file as! String)
                    print("The user File is\(userFileList)")
                }
            }
        }
    }
    
    
    func listOfFilesFromDropbox() {
        
        let path = "/Files"
        var fileName: String = ""
        
        print("The client address is \(String(describing: client))")
        
        print("The GET Current ACCOUNT   \(client!.users.getCurrentAccount())")
        
        
        client?.files.listFolder(path: path).response { response, error in
            
            print("*** List folder ***")
            
            if let result = response {
                
                print("Folder contents: \(String(describing: response))")
                
                for entry in result.entries {
                    
                    fileName = entry.name.replacingOccurrences(of: ".txt", with: "")
                    
                    if !self.dropBoxFiles.contains(fileName) {
                        print("The name is \(fileName)")
                        self.dropBoxFiles.append(fileName)
                    }
                    self.userDefaults.set(self.dropBoxFiles, forKey: "DropBoxFiles")
                }
                self.fetchUserFile()
                self.tableView.reloadData()
            }
            
            if  let errors = error{
                
                print("The List Error is : \(errors)")
            }
        }
    }
}

