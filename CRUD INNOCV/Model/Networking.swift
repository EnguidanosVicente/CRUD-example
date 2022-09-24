//
//  Networking.swift
//  CRUD INNOCV
//
//  Created by Vicente Enguidanos on 24/09/2022.
//

import UIKit

extension MainViewController{
    func addUpdate (user: User) {
        
        guard let jsonData = try? JSONEncoder().encode(user) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showAlert(message:"error calling POST")
                    print(error!)
                    return
                }
                guard data != nil else {
                    self.showAlert(message:"Did not receive data")
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    
                    switch response.statusCode {
                    case 200 ..< 300:
                        
                        self.showDone(message: "Data Added")
                        
                    default:
                        self.showAlert(message: "Error adding Data")
                    }
                }
            }
        }
        task.resume()
    }
    
    
    func readSingle(){
        
        let request : URLRequest = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if let error = error
            {
                self.showAlert(message: "task Error")
                print (error)
                
            }
            else if let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200 ..< 300:
                    print (response)
                default:
                    self.showAlert(message: "Error at response")
                }
            }
            
            DispatchQueue.main.async {
                
                guard let responseData = data else {
                    self.showAlert(message: "Empty data")
                    return
                }
                
                do{
                    let decodedUsers = try JSONDecoder().decode([User].self, from: responseData)
                    
                    for user in decodedUsers{
                        if Int(self.inputIDTextField.text!) != nil{
                            if user.id == Int(self.inputIDTextField.text!){
                                self.idTextField.text = String(user.id)
                                self.nameTextField.text = user.name
                                self.birthdateTextField.text = user.birthdate
                                
                            }
                        }
                    }
                    if self.idTextField.text == ""{
                        self.showAlert(message: "No data fetched")
                    }
                    
                } catch{
                    self.showAlert(message: "Error JSON decoding, please try again.")
                    print(error)
                }
            }
            
        })
        task.resume()
    }
    
    
    func readAll(){
        
        let request : URLRequest = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if let error = error
            {
                self.showAlert(message: "task Error")
                print (error)
                
            }
            else if let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200 ..< 300:
                    print (response)
                default:
                    print (response)
                }
            }
            
            DispatchQueue.main.async {
                
                guard let responseData = data else {
                    self.showAlert(message: "Empty data")
                    return
                }
                
                do{
                    let decodedUsers = try JSONDecoder().decode([User].self, from: responseData)
                    self.allUsers = decodedUsers
                    self.tableView.reloadData()
                } catch{
                    self.showAlert(message: "Error JSON decoding, please try again.")
                    print(error)
                }
            }
            
        })
        task.resume()
        
    }
    
    func removeUser (user: String){
        
        let url = URL(string: "https://hello-world.innocv.com/api/User/" + user)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
  
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.showAlert(message:"error calling POST")
                    print(error!)
                    return
                }
                guard data != nil else {
                    self.showAlert(message:"Did not receive data")
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    
                    switch response.statusCode {
                    case 200 ..< 300:
                        
                        self.showDone(message: "Data removed")
                        
                    default:
                        self.showAlert(message: "Error removing Data")
                        print (response)
                    }
                }
            }
        }
        task.resume()
    }
    
}
