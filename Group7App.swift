//
//  Group7App.swift
//  Group7
//
//  Created by Diya Patel on 2023-06-09.
//


import SwiftUI

@main
struct Group7App: App {
    
    var userStore = UserStore()
    var dataSource = DataSource()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userStore).environmentObject(dataSource)
        }
    }
}
