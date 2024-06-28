//
//  UITextField.swift
//  farmcontrol
//
//  Created by Oscar Escamilla on 21/06/24.
//

import UIKit


extension UITextField {
    
    
    
    func applyStyleDefault(){
        self.borderStyle = .roundedRect
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
        //self.textColor = .darkGray
        self.tintColor = .systemGreen
        //self.backgroundColor = .white
    }
}
