//
//  ForgotPasswordNib.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/29/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class ForgotPasswordNib: GeneralNibView {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    
    override func awakeFromNib() {
        setup(textField: emailTextField)
    }
    
    @IBAction func sendEmailButtonPressed(_ sender: Any) {
        guard let emailText = getText(ofTextField: emailTextField) else {
            errorLabel.text = "Please enter a username or email before submitting."
            return
        }
        
        print("Starting Forgot Password...")
        MySQLClient.sharedInstance.forgotPassword(ofUserWithInput: emailText) { result in
            DispatchQueue.main.async {
                switch result {
                case .Success(_):
                    print("call successful.")
                    self.delegate?.didSuccessfullySendAuthEmail(sender: self)
                    break
                case .Failure(let error):
                    self.errorLabel.text = "Failed to reset authentication. Please try again."
                    print("call failed: ", error)
                }
            }
        }
    }
}
