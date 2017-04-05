//
//  LoginNib.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/29/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class LoginNib: GeneralNibView {
    
    //MARK: - Variables
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var startExploringButton: UIButton!
    
    //MARK: - Setup
    
    override func awakeFromNib() {
        setup(textField: usernameTextField)
        setup(textField: passwordTextField)
        startExploringButton.layer.cornerRadius = startExploringButton.frame.height/4
    }
    
    //MARK: - Login Client Call

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let usernameText = getText(ofTextField: usernameTextField),
        let passwordText = getText(ofTextField: passwordTextField)
        else {
            errorLabel.text = "Please fill out both the username and password fields"
            return
        }
        
        print("Logging user in...")
        MySQLClient.sharedInstance.login(withID: usernameText, andPassword: passwordText) { result in
            switch result {
            case .Success(_):
                print("Login Successful")
                DispatchQueue.main.async {
                   self.delegate?.didGetSuccessfulLoginResult(sender: self)
                }
                break
            case .Failure(let error as ClientError):
                print("Login failed: ", error)
                DispatchQueue.main.async {
                self.errorLabel.text = "Invalid username or password"
                }
            default: break
            }
        }
    }

    
}
