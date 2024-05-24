//
//  ContentView.swift
//  Group7
//
//  Created by Diya Patel on 2023-06-09.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var dataSource: DataSource

    var body: some View {
        NavigationView {
            if userStore.isLoggedIn || UserDefaults.standard.bool(forKey: "isLoggedIn") {
                TabView {
                    ActivityListView().environmentObject(dataSource).tabItem {
                        Label("Discover", systemImage: "mappin.square.fill")
                    }
                    FavoriteView().environmentObject(dataSource).tabItem {
                        Label("Favorites", systemImage: "star.square.fill")
                    }
                }
                .navigationBarTitle(Text("Around Town"))
                .accentColor(Color.indigo)
                .navigationBarItems(trailing: Button("Logout") {
                    userStore.logoutUser()
                    print("User is not logged in1")
                })
            } else {
                LoginView(dataSource: dataSource)
                    .navigationBarHidden(true)
                    .onAppear {
                        print("User is not logged in")
                    }
            }
        }.accentColor(Color.indigo)

        .onAppear {
            if userStore.isLoggedIn || UserDefaults.standard.bool(forKey: "isLoggedIn") {
                print("User is logged in")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

