//
//  YelpBusinessLocation.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/21/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import Foundation

class YelpBusinessLocation {
    var address1: String
    var address2: String
    var address3: String
    var city: String
    var state: String
    var zipCode: String
    var country: String
    var displayAddress: [String]
    
    //for testing purposes
    init() {
        address1 = "25 Crescent St."
        address2 = ""
        address3 = ""
        city = "Waltham"
        state = "MA"
        zipCode = "02453"
        country = "USA"
        displayAddress = [address1, city + " " + state + " " + zipCode]
    }
    
    init(js: [String:Any]) {
        address1 = js["address1"] as? String ?? ""
        address2 = js["address2"] as? String ?? ""
        address3 = js["address3"] as? String ?? ""
        city = js["city"] as? String ?? ""
        state = js["state"] as? String ?? ""
        zipCode = js["zip_code"] as? String ?? ""
        country = js["country"] as? String ?? ""
        displayAddress = js["display_address"] as? [String] ?? []
    }
}
