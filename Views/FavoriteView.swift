//
//  FavoriteView.swift
//  Group7
//
//  Created by Mohammad AbuHannood on 2023-06-13.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var dataSource: DataSource
    @State private var isEmpty = false
    var body: some View {
        VStack{
            
            VStack{
                
                if self.isEmpty{
                    Text("No favorites found.").frame(height: 600)
                }else{
                    List{
                        ForEach(dataSource.favoriteList){favorite in
                            customListItemView(activity: favorite)
                        }
                        .onDelete{indexSet in
                            dataSource.removeFavoriteActivity(dataSource.favoriteList[indexSet.first!])
                        }
                    }
                    .listStyle(.plain)
                }
                
                if !self.isEmpty {
                    Button(action: {
                        dataSource.removeAllFavoriteActivities()
                    }) {
                        Text("Remove All")
                            .foregroundColor(Color.red)
                            .padding(.bottom,30)
                        
                    }
                }
                
            }.onAppear(perform: {
                if(dataSource.favoriteList.isEmpty){
                    self.isEmpty = true
                }else{
                    self.isEmpty = false
                }
            })
        }
    }
}



struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
