//
//  UserStore.swift
//  Group7
//
//  Created by Diya Patel on 2023-06-09.
//

import Foundation

class UserStore: ObservableObject {
    @Published var user: User? // Current logged-in user
    @Published var rememberMe = false // Remember Me toggle state
    @Published var isLoggedIn = false // User login state
    @Published var users: [User] = [] // Array of users
    
    // Sample user data for validation
    let sampleUsers: [User] = [
        User(name: "John Doe", email: "john@example.com", password: "john"),
        User(name: "Jane Smith", email: "jane@example.com", password: "jane")
    ]
    
    init() {
        users = sampleUsers
    }
    
    // Login user and set as current user
    func loginUser(email: String, password: String) {
        if let matchedUser = users.first(where: { $0.email == email && $0.password == password }) {
            user = matchedUser
            isLoggedIn = true
        }
    }
    
    // Logout the current user
    func logoutUser() {
        // Clear the stored user data
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")

        user = nil
        isLoggedIn = false
        rememberMe = false
        
    }

    
//    // Add a favorite activity for the current user
//    func addFavoriteActivity(_ activity: Activity) {
//        guard var currentUser = user else { return }
//
//        if !currentUser.favoriteActivities.contains(where: { $0.name == activity.name }) {
//            currentUser.favoriteActivities.append(activity)
//            user = currentUser // Update the user object
//        }
//    }
//
//    // Remove a favorite activity for the current user
//    func removeFavoriteActivity(_ activity: Activity) {
//        guard var currentUser = user else { return }
//
//        if let index = currentUser.favoriteActivities.firstIndex(where: { $0.name == activity.name }) {
//            currentUser.favoriteActivities.remove(at: index)
//            user = currentUser // Update the user object
//        }
//    }
//
//    // Remove all favorite activities for the current user
//    func removeAllFavoriteActivities() {
//        guard var currentUser = user else { return }
//        currentUser.favoriteActivities.removeAll()
//        user = currentUser // Update the user object
//    }
}
