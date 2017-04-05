//
//  GeneralNibClass.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/29/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit


class GeneralNibDelegateViewController: UIViewController {
    func didGetSuccessfulLoginResult(sender: LoginNib) {}
    func didSuccessfullySignUp(sender: SignUpNib) {}
    func didSuccessfullyConfirmAccount(sender: ConfirmSignUpNib) {}
    func didSuccessfullySendAuthEmail(sender: ForgotPasswordNib) {}
    func didSuccessfullyResetPassword(sender: ResetPasswordNib) {}
}

class GeneralNibView: UIView {
    var delegate: GeneralNibDelegateViewController?
    
    func setup(textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.cornerRadius = textField.frame.height/4
    }
    
    func setup(button: UIButton) {
        button.layer.cornerRadius = button.frame.height/4
    }
    
    func getText(ofTextField textField: UITextField) -> String? {
        guard let text = textField.text, !text.isEmpty else { return nil }
        return text
    }
    
    func toggleColors(forTextField textField: UITextField, colorPurple: Bool) {
        textField.layer.borderColor = colorPurple ? UIColor(red: 105/255, green: 0.0, blue: 105/255, alpha: 1.0).cgColor : UIColor.darkGray.cgColor
        textField.textColor = colorPurple ? .red : .black
    }
}
