//
//  MySQLClient.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/28/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import Foundation

class MySQLClient: GeneralClient {
    
    //MARK: - Final variables
    
    final let BASE_URL = "http://sample-env-1.jzxt6wkppr.us-east-1.elasticbeanstalk.com/Explore/android_backend/"
    final let LOGIN_URL = "login.php"
    final let CREATE_USER_URL = "create_user.php"
    
    //MARK: - Singleton
    static let sharedInstance = MySQLClient()
    private override init() {}
    
    func login(withID userID:String, andPassword password:String, completion: @escaping (Result) -> Void) {
        let params: [String: String] = [
            "user_id": userID,
            "password": password
        ]
        
        guard let request = setupRequest(withURL: BASE_URL + LOGIN_URL, type: "POST", headers: [:], params: params) else {
            completion(.Failure(ClientError.ErrorSettingUpRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.Failure(error))
            } else if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                        completion(.Failure(ClientError.ErrorParsingJson))
                        return
                    }
                    
                    if json["success"] as? Int == 1 {
                        completion(.Success(""))
                    } else {
                        completion(.Failure(ClientError.Unknown))
                    }
                    
                } catch let error {
                    completion(.Failure(error))
                }
            }
            
        }.resume()
    }
    
    func createUser(withNewUser user: User, completion: @escaping (Result) -> Void) {
        let params: [String: String] = [
            "user_id": user.userID,
            "password": user.password,
            "email": user.email,
            "first_name": user.firstName,
            "last_name": user.lastName
        ]
        
        guard let request = setupRequest(withURL: BASE_URL + CREATE_USER_URL, type: "POST", headers: [:], params: params) else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.Failure(error))
            } else if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                        completion(.Failure(ClientError.ErrorParsingJson))
                        return
                    }
                    
                    if json["success"] as? Int == 1 {
                        completion(.Success(""))
                    } else {
                        completion(.Failure(ClientError.Unknown))
                    }
                    
                } catch let error {
                    completion(.Failure(error))
                }
            }
        }.resume()
    }

    
    
    
    
    
}
