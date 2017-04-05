//
//  MySQLClient.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/28/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import Foundation

enum SignUpError: Error {
    case UserNameOrEmailAlreadyTaken
    case CouldNotSendEmail
    case Unknown
}

class MySQLClient: GeneralClient {
    
    //MARK: - Final variables
    
    final private let BASE_URL = "http://sample-env-1.jzxt6wkppr.us-east-1.elasticbeanstalk.com/Explore/website/"
//    final private let BASE_URL = "http://localhost/Explore/website/"
    final private let LOGIN_URL = "login.php"
    final private let CREATE_USER_URL = "create_user.php"
    final private let CONFIRM_ACCOUNT_URL = "confirm_user.php"
    final private let FORGOT_PASSWORD_URL = "forgot_password.php"
    final private let RESET_PASSWORD_URL = "reset_password.php"
    
    //MARK: - Singleton
    
    static let sharedInstance = MySQLClient()
    private override init() {}
    
    //MARK: - Basic URL Call
    
    func basicURLCall(withRequest request: URLRequest, completion: @escaping (Result) -> Void) {
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
    
    func login(withID userID:String, andPassword password:String, completion: @escaping (Result) -> Void) {
        let params: [String: String] = [
            "user_auth": userID,
            "password": password,
            "android": " "
        ]
        
        guard let request = setupRequest(withURL: (BASE_URL + LOGIN_URL), type: "POST", headers: [:], params: params) else {
            completion(.Failure(ClientError.ErrorSettingUpRequest))
            return
        }
        
        basicURLCall(withRequest: request, completion: completion)
    }
    
    func createUser(withNewUser user: User, completion: @escaping (Result) -> Void) {
        let params: [String: String] = [
            "user_id": user.userID,
            "password": user.password,
            "email": user.email,
            "first_name": user.firstName,
            "last_name": user.lastName,
            "android": " "
        ]
        
        guard let request = setupRequest(withURL: BASE_URL + CREATE_USER_URL, type: "POST", headers: [:], params: params) else {
            completion(.Failure(ClientError.ErrorSettingUpRequest))
            return
        }

        basicURLCall(withRequest: request, completion: completion)
    }

    func confirmAccount(ofUser userInput: String, withAuthenticationCode authCode: String, completion: @escaping (Result) -> Void) {
        let params: [String:String] = [
            "confirm_user_user_input": userInput,
            "authentication_code": authCode,
            "android": " "
        ]
        
        guard let request = setupRequest(withURL: BASE_URL + CONFIRM_ACCOUNT_URL, type: "POST", headers: [:], params: params) else {
            completion(.Failure(ClientError.ErrorSettingUpRequest))
            return
        }
        
        basicURLCall(withRequest: request, completion: completion)
    }
    
    func forgotPassword(ofUserWithInput userInput:String, completion: @escaping (Result) -> Void) {
        let params: [String:String] = [
            "forgot_password_user_input": userInput,
            "android": " "
        ]
        
        guard let request = setupRequest(withURL: BASE_URL + FORGOT_PASSWORD_URL, type: "POST", headers: [:], params: params) else {
            completion(.Failure(ClientError.ErrorSettingUpRequest))
            return
        }
        
        basicURLCall(withRequest: request, completion: completion)
    }
    
    func resetPassword(ofUser user: String, toPassword password: String,  withAuthenticationCode authCode: String, completion: @escaping (Result) -> Void) {
        let params: [String:String] = [
            "reset_password_user_input": user,
            "password": password,
            "authentication_code": authCode,
            "android": " "
        ]
        
        guard let request = setupRequest(withURL: BASE_URL + RESET_PASSWORD_URL, type: "POST", headers: [:], params: params)
            else {
            completion(.Failure(ClientError.ErrorSettingUpRequest))
            return
        }
        
        basicURLCall(withRequest: request, completion: completion)
    }
}
