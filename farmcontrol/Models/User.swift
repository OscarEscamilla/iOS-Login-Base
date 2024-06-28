//
//  User.swift
//  farmcontrol
//
//  Created by Oscar Escamilla on 13/06/24.
//

import Foundation



struct User: Codable {
    var id: String
    var name: String
    var email: String
    var isActive: Bool = true
}
