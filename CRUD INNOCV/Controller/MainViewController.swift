//
//  ViewController.swift
//  CRUD INNOCV
//
//  Created by Vicente Enguidanos on 23/09/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var readAllButton: UIButton!
    @IBOutlet weak var inputIDTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    
    let url = URL(string: "https://hello-world.innocv.com/api/User")
    
    var allUsers : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    @IBAction func updatePressed(_ sender: UIButton) {
        
        if nameTextField.text != nil && nameTextField.text != ""{
            if idTextField.text != nil && idTextField.text != ""{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                if dateFormatter.date(from:birthdateTextField.text!) != nil{
                    
                    let newUser = User(id: Int(idTextField.text!)!, name: nameTextField.text!, birthdate: birthdateTextField.text!)
                    
                    addUpdate(user: newUser)
                    
                }else{
                    showAlert(message:"Erroneus date format, insert yyyy-MM-dd'T'HH:mm:ss")
                }
            }
        }
        
    }
    
    @IBAction func createPressed(_ sender: UIButton) {
        
        if nameTextField.text != nil && nameTextField.text != ""{
            if Int(idTextField.text!) == 0{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                if dateFormatter.date(from:birthdateTextField.text!) != nil{
                    
                    let newUser = User(id: Int(idTextField.text!)!, name: nameTextField.text!, birthdate: birthdateTextField.text!)
                    
                    addUpdate(user: newUser)
                    
                }else{
                    showAlert(message:"Erroneus date format, insert yyyy-MM-dd'T'HH:mm:ss")
                }
            }else{
                showAlert(message:"ID must be 0")
            }
        }
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        
        if inputIDTextField.text != nil && inputIDTextField.text != ""{
            
            removeUser(user: inputIDTextField.text!)
            
        }
        
    }
    
    @IBAction func readPressed(_ sender: UIButton) {
        
        readSingle()
    }
    
    @IBAction func readAllPress(_ sender: UIButton) {
        
        readAll()
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        cell.idLabel.text = String(allUsers[indexPath.row].id)
        cell.nameLabel.text = allUsers[indexPath.row].name
        cell.birthLabel.text = allUsers[indexPath.row].birthdate
        
        return cell
    }
    
}

