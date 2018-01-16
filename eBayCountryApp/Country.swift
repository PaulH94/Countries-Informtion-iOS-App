//
//  Country.swift
//  eBayCountryApp
//
//  Created by Paul Huynh on 1/15/18.
//  Copyright © 2018 Paul Huynh. All rights reserved.
//

import Foundation
//A struct that is used to store some of the JSON data
//Note: "Codable" means that it can be used to encode and decode JSON data.
//The varible name have to match the JSON key and the type has to match.
//A number of more data could have been recorded, but for this exercise I am going to only get what I
//need and data that I think are more important to "people" who would use the app
struct Country: Codable{
    let name: String
    let capital: String
    let population: Int
    let latlng: [Double]
    let nativeName: String      //String class takes care of unicode
    let subregion: String
    let area: Double?           //Potentially used for map span
    let alpha2Code: String      //Potentially used for flags
}
