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
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UITextField!
    
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: - Sign Up Client Call
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        //...
        delegate?.didSuccessfullySignUp(sender: self)
    }
}
