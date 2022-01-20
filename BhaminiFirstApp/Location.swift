//
//  Location.swift
//  BhaminiFirstApp
//
//  Created by Sundararaman, Bhamini on 5/26/21.
//

import Foundation

//custom data structure for location
struct Location: Decodable, Identifiable{  //identifiable will make it so we can loop through the locations
    
    let id: Int
    let name: String
    let country: String
    let description: String
    let more: String
    let latitude: Double
    let longitude: Double
    let heroPicture: String
    let advisory: String
    
    
    static let example = Location(id: 1,name: "Great  Smokey Mountains", country: "United States", description: "A great place to visit.", more: "More text here.", latitude: 35.3434, longitude: -86.9789, heroPicture: "smokies",advisory: "Beware of the bears")
    
}
