//
//  NotesViewController.swift
//  NotesApp
//
//  Created by user on 5/4/17.
//  Copyright © 2017 full. All rights reserved.
//

import UIKit




class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var userTexts = [String: String]()
    var userText:[String] = []
    //var textField: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Did Load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will Appear")
        self.tabBarController?.navigationItem.title = "Notes"
        
        let sendButton = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(goToNoteEditorViewController))
        
        self.tabBarController?.navigationItem.rightBarButtonItem = sendButton
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("View Did appear")
        let userDefaults = UserDefaults()
        
        if let dictionary = userDefaults.dictionary(forKey: "UserNotes"){
            if let dictionaryTexts = dictionary as? [String : String] {
                userText = [String](dictionaryTexts.keys)
                
                print("array values: \(userText)")
                 self.tableView.reloadData()
            }
        }
    }
    
    func goToNoteEditorViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier:"NoteEditorViewID") as? NoteEditorViewController else{
            return
        }
        present(viewController, animated: true, completion: nil)
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

        return userText.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = userText[indexPath.row]
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
}







