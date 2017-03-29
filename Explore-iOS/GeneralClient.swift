//
//  GeneralClient.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/28/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import Foundation

enum ClientError: Error {
    case Unknown
    case ErrorSettingUpRequest
    case ErrorParsingJson
}

enum Result {
    case Success(Any)
    case Failure(Error)
}

class GeneralClient {
    
    func setupRequest(withURL url: String, type: String, headers: [String: String], params: [String: String]) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = type
        request.allHTTPHeaderFields = headers
        
        var paramString:String = ""
        if (!params.isEmpty) {
            for (key,value) in params {
                paramString += key + "=" + value + "&"
            }
            paramString = paramString.substring(to: paramString.index(before: paramString.endIndex))
            request.httpBody = paramString.data(using: .utf8)
        }
        return request
    }
}
