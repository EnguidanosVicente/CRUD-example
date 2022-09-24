//
//  showAlert.swift
//  CRUD INNOCV
//
//  Created by Vicente Enguidanos on 23/09/2022.
//

import UIKit

extension MainViewController{
    func showAlert(message: String){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(actionOk)
        
        present(alert, animated: true, completion: nil)
        
    }
}
