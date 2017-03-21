//
//  ViewController.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/21/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func randomizeButtonPressed(_ sender: Any) {
        //Yelp Call Here
        YelpClient.sharedInstance.getYelpToken { result in
            switch result {
            case .Success(_):break
            case .Failure(let error):
                print(error)
                break
            }
            
        }
    }
}

