//
//  YelpBusiness.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/21/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import Foundation

class YelpBusiness {
    var id: String
    var name: String
    var reviewCount: Int
    var rating: Double
    var distance: Double
    var categories: [String:Any]
    var url: String
    var phone: String
    var displayPhone: String
    var isClosed: Bool
    var location: YelpBusinessLocation
    var imageURL: String
    var coordinates: [String:Any]
    
    init(js: [String:Any]) {
        id = js["id"] as? String ?? ""
        name = js["name"] as? String ?? ""
        reviewCount = js["review_count"] as? Int ?? 0
        rating = js["rating"] as? Double ?? 0.0
        distance = js["distance"] as? Double ?? 0.0
        distance *= 0.000621371 //changes distance from meters to miles
        categories = js["categories"] as? [String:Any] ?? [:]
        url = js["url"] as? String ?? ""
        phone = js["phone"] as? String ?? ""
        displayPhone = js["display_phone"] as? String ?? ""
        isClosed = js["is_closed"] as? Bool ?? true
        
        let jsLocation = js["location"] as? [String:Any] ?? [:]
        location = YelpBusinessLocation(js: jsLocation)

        imageURL = js["image_url"] as? String ?? ""
        coordinates = js["coordinates"] as? [String:Any] ?? [:]
    }
}
