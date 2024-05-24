//
//  User.swift
//  Group7
//
//  Created by Diya Patel on 2023-06-09.
//

import Foundation

struct User : Codable {
    let name: String
    let email: String
    let password: String
    var favoriteActivities: [Activity] = []
}

// Sample user data for validation
let sampleUsers = [
    User(name: "John Doe", email: "john@example.com", password: "john"),
    User(name: "Jane Smith", email: "jane@example.com", password: "jane")
]
