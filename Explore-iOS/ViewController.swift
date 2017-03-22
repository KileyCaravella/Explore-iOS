//
//  ViewController.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/21/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class ViewController: UIViewController, YelpViewControllerDelegate {

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
        YelpClient.sharedInstance.searchYelpBusinesses(withLocation: "35-Crescent-St-Waltham-MA") { result in
            switch result {
            case .Success(let businesses):
                guard let yelpVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "yelpVC") as? YelpViewController,
                    let businesses = businesses as? [YelpBusiness] else {return}
                yelpVC.yelpBusinessArray = businesses
                yelpVC.delegate = self
                DispatchQueue.main.async {
                    self.present(yelpVC, animated: true, completion: nil)
                }
                
                break
            case .Failure(let error):
                print(error)
                break
            }
            
        }
    }
    
    func didRequestToDismissYelpViewController(sender: UIViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
