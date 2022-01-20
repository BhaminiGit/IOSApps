//
//  ContentView.swift
//  BhaminiFirstApp
//
//  Created by Sundararaman, Bhamini on 5/24/21.
//
//37 min

//command r runs program
//option command p resume preview

import SwiftUI

struct ContentView: View {
    
    let location: Location
    
    var body: some View {
        
       
        //VStack{ //Vstack will vertically stack the image and the text
        ScrollView{ //scroll view will give a scroll view
            
            Image(location.heroPicture) //display an image
                .resizable() //allows us to change the size of the image
                .scaledToFit() //scales nicely
            
            Text(location.name) //display some text
                .font(.largeTitle) //change font of text , large Title gives you large font based on devive. As the configuration changes the font will show as "large" and adapt
        
                .bold()
                .multilineTextAlignment(.center) //without this, swift will just left align
            
            Text(location.country)
                .font(.title) //title, but not large as Largetitle
                .foregroundColor(.secondary) //just a secondary color,
                        //if we had used grey, the system won't adapt
            
            Text(location.description)
                .padding(.horizontal)
            
            
            Text("Did you know??")
                .font(.title3)
                .bold()
                .padding(.top)
                //if we just do .padding, we say padding everywhere
                    //.top says only the top
            
            Text(  location.more)
                .padding(.horizontal)
            
        }
        
        .navigationTitle("Discover")
        
    }
}


//just for xcode preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some  View {
        ContentView(location: Location.example)
    }
}
