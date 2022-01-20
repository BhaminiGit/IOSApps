//
//  BhaminiFirstAppApp.swift
//  BhaminiFirstApp
//
//  Created by Sundararaman, Bhamini on 5/24/21.
//

import SwiftUI

//https://developer.apple.com/sf-symbols/

@main
struct BhaminiFirstAppApp: App {
    
    @StateObject var locations = Locations()
   
    var body: some Scene {
        WindowGroup {
            TabView{
                
                NavigationView{// we won't be overlapping the clock
                    ContentView(location: locations.primary)
                }
                .tabItem {
                    Image(systemName: "airplane.circle.fill") //icon
                    Text("Discover")
                }
                
                
                NavigationView{
                    WorldView()
                }
                .tabItem {
                    
                    Image(systemName: "star.fill") //icon
                    Text("Locations") //text
                }
                
                NavigationView {
                    TipsView()
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tips")
                }
                
               
            }
            .environmentObject(locations)
        }
    }
}

