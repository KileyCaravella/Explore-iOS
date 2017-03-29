//
//  NavigationController.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/27/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//


import UIKit

class NavigationController: UINavigationController {
//    private let backArrowIconImage = UIImage(named: "backArrowIcon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationBar.barTintColor = UIColor(red: 183/255, green: 159/255, blue: 255/255, alpha: 1.0)
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBar.isTranslucent = false
        
//        navigationBar.backIndicatorTransitionMaskImage = backArrowIconImage
//        navigationBar.backIndicatorImage = backArrowIconImage
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
}
