//
//  showDone.swift
//  CRUD INNOCV
//
//  Created by Vicente Enguidanos on 24/09/2022.
//

import Foundation

import UIKit

extension MainViewController{
    func showDone(message: String){
        
        let alert = UIAlertController(title: "Well Done!", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(actionOk)
        
        present(alert, animated: true, completion: nil)
        
    }
}
