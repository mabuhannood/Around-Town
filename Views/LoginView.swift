//
//  LoginView.swift
//  Group7
//
//  Created by Diya Patel on 2023-06-09.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var dataSource: DataSource
    @EnvironmentObject var userStore: UserStore
    @State private var email = ""
    @State private var password = ""
    @State private var isActive = false // New state variable
    @State private var showAlert = false // New state variable for showing alert
    @State private var alertMessage = "" // New state variable for alert message
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Image("torontologo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 20)

                    Text("Email")
                        .font(.headline)
                    TextField("Please enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                }
                .padding(.vertical)
                .padding(.horizontal)
                        
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.headline)
                    SecureField("Please enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.vertical)
                .padding(.horizontal)
                        
                Toggle("Remember Me", isOn: $userStore.rememberMe)
                    .padding()
                        
                Button(action: login) {
                    Text("Login")
                        .padding(.vertical ,15)
                        .padding(.horizontal, 30)
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                .padding()
                        
                NavigationLink(destination: ActivityListView(), isActive: $isActive) {
                    EmptyView()
                }
            }
            .padding(.horizontal, 18)
            .navigationBarTitle(Text("Login"), displayMode: .inline)
            .navigationBarHidden(false)
            .onAppear {
                // Check if Remember Me is enabled and user is available
                if userStore.rememberMe && userStore.user == nil {
                    // Check if the user is already logged in from the previous session
                    let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
                    
                    if isLoggedIn {
                        // Retrieve the stored user data
                        if let name = UserDefaults.standard.string(forKey: "name"),
                           let email = UserDefaults.standard.string(forKey: "email"),
                           let password = UserDefaults.standard.string(forKey: "password") {
                            userStore.user = User(name: name, email: email, password: password)
                            userStore.isLoggedIn = true
                            isActive = true // Activate the navigation link
                            print("User logged in from previous session")
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func login() {
        // Form field validation for email
        guard !email.isEmpty else {
            alertMessage = "Please enter email."
            showAlert = true
            return
        }
        
        // Form field validation for password
        guard !password.isEmpty else {
            alertMessage = "Please enter password."
            showAlert = true
            return
        }
        
        // Check if the user exists
        guard let matchedUser = sampleUsers.first(where: { $0.email == email }) else {
            alertMessage = "Email does not exist."
            showAlert = true
            return
        }
        
        // Check if the password is correct
        guard matchedUser.password == password else {
            alertMessage = "Incorrect password."
            showAlert = true
            return
        }
        
        // Login the user
        userStore.loginUser(email: email, password: password)
        
        // Navigate to ActivitiesView if login is successful
        if userStore.isLoggedIn {
            if userStore.rememberMe {
                // Store user data in session for automatic login
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(matchedUser.name, forKey: "name")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(password, forKey: "password")
            }
            
            
            email = ""
            password = ""
            
            isActive = true // Activate the navigation link
            
            print("User logged in successfully")
        }
    }
}
