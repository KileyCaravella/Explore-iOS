//
//  SignUp.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/29/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class SignUpNib: GeneralNibView {
    
    //MARK: - Variables
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        setup(textField: usernameTextField)
        setup(textField: passwordTextField)
        setup(textField: confirmPasswordTextField)
        setup(textField: firstNameTextField)
        setup(textField: lastNameTextField)
        setup(textField: emailTextField)
        
        setup(button: signUpButton)
    }
    
    //MARK: - Sign Up Client Call
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        guard let usernameText = getText(ofTextField: usernameTextField),
            let passwordText = getText(ofTextField: passwordTextField),
            let confirmText = getText(ofTextField: confirmPasswordTextField),
            let firstNameText = getText(ofTextField: firstNameTextField),
            let lastNameText = getText(ofTextField: lastNameTextField),
            let emailText = getText(ofTextField: emailTextField)
            else {
                errorLabel.text = "Please fill out all fields."
                return
        }
        
        if passwordText != confirmText {
            toggleColors(forTextField: passwordTextField, colorPurple: true)
            toggleColors(forTextField: confirmPasswordTextField, colorPurple: true)
            errorLabel.text = "Passwords do not match. Please re-enter."
            return
        }
        
        toggleColors(forTextField: passwordTextField, colorPurple: false)
        toggleColors(forTextField: confirmPasswordTextField, colorPurple: false)
        
        let user = User()
        user.userID = usernameText
        user.password = passwordText
        user.firstName = firstNameText
        user.lastName = lastNameText
        user.email = emailText

        print("Starting Sign Up Call...")
        MySQLClient.sharedInstance.createUser(withNewUser: user) { result in
            switch result {
            case .Success(_):
                print("call successful")
                DispatchQueue.main.async {
                    self.delegate?.didSuccessfullySignUp(sender: self)
                }
            case .Failure(let error):
                print("call failed: ", error)
                DispatchQueue.main.async {
                    if let error = error as? SignUpError {
                        switch error {
                        case .CouldNotSendEmail:
                            self.errorLabel.text = "Count not send email to entered address. Please try again."
                            break
                        case .UserNameOrEmailAlreadyTaken:
                            self.errorLabel.text = "Username or email already exist."
                            break
                        default:
                            break
                        }
                    } else {
                        self.errorLabel.text = "Unknown error occured. Please try again"
                    }
                }
            }
        }
    }
}
