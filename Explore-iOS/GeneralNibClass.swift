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
}

class GeneralNibView: UIView {
    var delegate: GeneralNibDelegateViewController?
}
