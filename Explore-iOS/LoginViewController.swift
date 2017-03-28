//
//  Login.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/27/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var navCon: NavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let randomizeVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "randomizeVC") as? RandomizeViewController else { return }
        
        let navCon = NavigationController(rootViewController: randomizeVC)
        self.present(navCon, animated: true, completion: nil)
    }
}
