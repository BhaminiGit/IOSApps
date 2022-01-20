//
//  Locations.swift
//  BhaminiFirstApp
//
//  Created by Sundararaman, Bhamini on 5/26/21.
//

import Foundation

class Locations: ObservableObject{
    let places: [Location]
    
    var primary: Location{
        places[0]
    }
    
    init(){
        //find locations.json
        // the '!' is to say "if this doesn't work, CRASH THE WHOLE APP"
        let url = Bundle.main.url(forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        places = try! JSONDecoder().decode([Location].self, from: data)
        
    
    }
    
}
