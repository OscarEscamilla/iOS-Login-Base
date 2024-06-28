//
//  UIViewController+Extensions.swift
//  farmcontrol
//
//  Created by Oscar Escamilla on 25/06/24.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlert(title:String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { _ in
            print("ok tapped")
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
