//
//  APIClient.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/21/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import Foundation

class YelpClient: GeneralClient {
    
    final let BASE_URL = "https://api.yelp.com/"
    final let AUTH_URL = "oauth2/token"
    final let SEARCH_URL = "v3/businesses/search?limit="
    
    final let BUSINESSES_RETURNED_LIMIT = "10"
    
    final let CLIENT_ID = "4NMYNrNO_HRZm9u9mPlH2w"
    final let CLIENT_SECRET = "roPjBQkz8jRRaIhpw8ScW4y1Z875JJTe22tPF2mKSo7EIoKcW0wNKLp3wFz9yyAF"
    var YELP_TOKEN = ""
    
    //Class has a singleton, meaning only one ever exists.
    static let sharedInstance = YelpClient()
    private override init() {}
    
    func getYelpToken(completion: @escaping (Result) -> Void) {
        print("Retrieving Token...")
        let headers: [String: String] = [
            "Content-Type":"application/x-www-form-urlencoded"
        ]
        
        let params: [String:String] = [
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET,
            "grant_type":"client_credentials"
        ]
        
        guard let request = setupRequest(withURL: BASE_URL + AUTH_URL, type: "POST", headers: headers, params: params) else {
            completion(.Failure(ClientError.ErrorSettingUpRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.Failure(error))
            } else if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any], let tokenType = json["token_type"] as? String, let accessToken = json["access_token"] as? String else {
                        completion(.Failure(ClientError.ErrorParsingJson))
                        return
                    }
                    self.YELP_TOKEN = tokenType + " " + accessToken
                    print("Token Retrieved.")
                    completion(.Success(""))
                } catch let error {
                    completion(.Failure(error))
                }
                
            }
        }.resume()
    }
    
    func searchYelpBusinesses(withLatitude latitude: Double, andLongitude longitude: Double, completion: @escaping (Result) -> Void) {
        let appendingURLString = "&latitude=" + String(format:"%f", latitude) + "&longitude=" + String(format:"%f", longitude)
        searchYelpBusinesses(withAppendingURL: appendingURLString) { result in
            completion(result)
        }
    }
    
    func searchYelpBusinesses(withLocation location: String, completion: @escaping (Result) -> Void) {
        let appendingURLString = "&location=" + location
        searchYelpBusinesses(withAppendingURL: appendingURLString) { result in
            completion(result)
        }
    }
    
    private func searchYelpBusinesses(withAppendingURL appendingURL: String, completion: @escaping (Result) -> Void) {
        let url = SEARCH_URL + BUSINESSES_RETURNED_LIMIT + appendingURL
        if YELP_TOKEN == "" {
            getYelpToken{ result in
                switch result {
                case .Success(_):
                    self.searchYelpBusinesses(withURL: url) { result in
                        completion(result)
                    }
                case .Failure(_):
                    completion(result)
                }
            }
        } else {
            searchYelpBusinesses(withURL: url) { result in
                completion(result)
            }
        }
    }
    
    private func searchYelpBusinesses(withURL url: String, completion: @escaping (Result) -> Void) {
        print("Retrieving Businesses...")
        let headers: [String: String] = [
            "Authorization": YELP_TOKEN
        ]
        guard let request = setupRequest(withURL: BASE_URL + url, type: "GET", headers: headers, params: [:]) else {
            completion(.Failure(ClientError.ErrorSettingUpRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.Failure(error))
            } else if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any], let businesses = json["businesses"] as? [[String:Any]] else {
                        completion(.Failure(ClientError.ErrorParsingJson))
                        return
                    }
                    
                    var yelpBusinesses: [YelpBusiness] = []
                    for business in businesses {
                        yelpBusinesses.append(YelpBusiness(js:business))
                    }
                    print(yelpBusinesses.count, "business[es] found.")
                    completion(.Success(yelpBusinesses))
                } catch let error {
                    completion(.Failure(error))
                }
            }
        }
        task.resume()
    }
}
