//
//  Activity.swift
//  Group7
//
//  Created by Mohammad AbuHannood on 2023-06-12.
//

import Foundation

class Activity: Identifiable, Codable{
    var id = UUID()
    var name: String
    var description :String
    var rating : Int
    var hostName :String
    var images: [String]
    var price :Double
    var phone: String
    
    init(){
        self.name = "NA"
        self.description = "NA"
        self.rating = 1
        self.hostName = "NA"
        self.images = ["NA"]
        self.price = 0
        self.phone = "(000)-000-0000"
    }
    
    init(name: String, description: String, rating: Int, hostName: String, images: [String], price: Double, phone:String) {
        self.name = name
        self.description = description
        self.rating = rating
        self.hostName = hostName
        self.images = images
        self.price = price
        self.phone = phone
    }
    
    func displayInfo(){
        print("id: \(id), Name: \(name), Rating: \(rating), Hostname: \(hostName), Price: \(price), Phone: \(phone)")
    }
}
