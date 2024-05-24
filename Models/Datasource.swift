//
//  Datasource.swift
//  Group7
//
//  Created by Mohammad AbuHannood on 2023-06-12.
//

import Foundation

class DataSource: ObservableObject{
    @Published var activityList: [Activity] = [Activity]()
    @Published var favoriteList: [Activity] = [Activity]() {
            didSet {
                saveFavoritesToUserDefaults()
            }
        }
    
    // Function to fill activity list with sample data
    func fillActivities(){
        activityList.append(Activity(name: "Discover Toronto by Water",
                                     description: "Tour the beautiful Lake Ontario Toronto. Enjoy beautiful sites of city, beaches and hidden gems from the water. Many sights are only accessible by boat and untraveled and unknown to many with access to boat.",
                                     rating: 5, hostName: "Mai", images: ["byWater1","byWater2"],price: 99.00, phone: "(647)-123-4567"))
        
        activityList.append(Activity(name: "Toronto Islands Morning Bike Tour",
                                     description: "Just minutes from the busy, bustling downtown core of the city you’ll find the Toronto Islands–a five-kilometre oasis of interconnected islands that locals have been escaping to for fun, relaxation and tranquility for over 200 years.", rating: 4, hostName: "Terrence", images: ["byBike1","byBike2"], price: 108.0, phone: "(647)-123-4567"))
        
        activityList.append(Activity(name: "Gelato Tasting & Gelato Production Tour", description: "Death in Venice Gelato is Toronto’s award winning best gelateria. I am the owner and the gelato maker of this unique gelato shop. The experience is a 16 course gelato tasting with a visit to the gelato lab where all the creative flavours are tested & produced.",
                                     rating: 4, hostName: "Kaya", images: ["gelato1","gelato2"], price: 65.0, phone: "(647)-123-4567"))
        
        activityList.append(Activity(name: "Record Collecting & Music History Walking Tour", description: "A Vinyl Record collecting tour that explores Toronto's music, history and local record shops.", rating: 4, hostName: "Mike", images: ["records1","records2"], price: 250.00, phone: "(647)-123-4567"))
        
        activityList.append(Activity(name: "Niagara, Maple, Wine & Hike", description: "Join us for a day tour to Niagara Region. We will start with short hike at Ball's Falls Conservation area. Than we will visit local winery and maple farm. Ice wine and maple syrup are two Canadian liquid golds which you should definitely try on your Niagara visit.", rating: 5, hostName: "Lenka", images: ["niagara1","niagara2"], price: 175.00, phone: "(647)-123-4567"))
    }
    
    // Function to remove a favorite activity
    func removeFavoriteActivity(_ activity: Activity) {
        if let index = favoriteList.firstIndex(where: { $0.name == activity.name }) {
            favoriteList.remove(at: index)
        }
    }

    // Function to remove all favorite activities
    func removeAllFavoriteActivities() {
        favoriteList.removeAll()
    }

    // Function to add a favorite activity
    func addFavoriteActivity(_ activity: Activity) {
            if favoriteList.firstIndex(where: { $0.name == activity.name }) == nil {
                favoriteList.append(activity)
            }
    }
    
    // Function to save favorite activities to UserDefaults
    private func saveFavoritesToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteList) {
            UserDefaults.standard.set(encoded, forKey: "favoriteList")
        }
    }
    
    // Function to load favorite activities from UserDefaults
    private static func loadFavoritesFromUserDefaults() -> [Activity] {
        if let data = UserDefaults.standard.data(forKey: "favoriteList") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    
}
