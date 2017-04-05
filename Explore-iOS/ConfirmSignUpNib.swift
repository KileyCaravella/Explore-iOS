//
//  ConfirmSignUpNib.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/29/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class ConfirmSignUpNib: GeneralNibView {
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var authenticationCodeTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
   
    override func awakeFromNib() {
        setup(textField: usernameTextField)
        setup(textField: authenticationCodeTextField)
        setup(button: confirmButton)
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        guard let usernameText = getText(ofTextField: usernameTextField),
            let authCodeText = getText(ofTextField: authenticationCodeTextField) else {
                informationLabel.text = "Please fill out both fields."
                return
        }
        
        print("Starting Confirming Account...")
        MySQLClient.sharedInstance.confirmAccount(ofUser: usernameText, withAuthenticationCode: authCodeText) { result in
            DispatchQueue.main.async {
                switch result {
                case .Success(_):
                        print("call successful.")
                        self.delegate?.didSuccessfullyConfirmAccount(sender: self)
                    break
                case .Failure(let error):
                    print("call failed: ", error)
                    self.informationLabel.text = "Error Occured. Please try again."
                }
            }
        }
    }
}
