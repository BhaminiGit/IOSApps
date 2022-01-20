//
//  Tip.swift
//  BhaminiFirstApp
//
//  Created by Sundararaman, Bhamini on 5/27/21.
//

import Foundation

//the children may be there or may not be there
struct Tip: Decodable{
    let text : String
    let children: [Tip]? //'?'  optional, may or may not have children
    
}
