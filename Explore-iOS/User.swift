//
//  User.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/28/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import Foundation

class User {
    var userID:String
    var firstName:String
    var lastName: String
    var email: String
    var password: String
    var authenticationCode: String
    
    init() {
        userID = ""
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        authenticationCode = ""
    }
}
