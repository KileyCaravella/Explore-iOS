//
//  ResetPasswordNib.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 4/4/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit



class ResetPasswordNib: GeneralNibView {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var authenticationCodeTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var startExploringButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup(textField: usernameTextField)
        setup(textField: passwordTextField)
        setup(textField: confirmPasswordTextField)
        setup(textField: authenticationCodeTextField)
        setup(button: startExploringButton)
    }

    @IBAction func startExploringButtonPressed(_ sender: UIButton) {
        guard let usernameText = getText(ofTextField: usernameTextField),
            let passwordText = getText(ofTextField: passwordTextField),
            let confirmText = getText(ofTextField: confirmPasswordTextField),
            let authCodeText = getText(ofTextField: authenticationCodeTextField)
            else {
                errorLabel.text = "Please fill out both fields."
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
        
        
        print("Starting Reset Password...")
        MySQLClient.sharedInstance.resetPassword(ofUser: usernameText, toPassword: passwordText, withAuthenticationCode: authCodeText) { result in
            DispatchQueue.main.async {
                switch result {
                case .Success(_):
                    print("call successful.")
                    self.delegate?.didSuccessfullyResetPassword(sender: self)
                case .Failure(let error):
                    print("call failed: ", error)
                    self.errorLabel.text = "Error Occured. Please try again."
                }
            }
        }
    }
}
