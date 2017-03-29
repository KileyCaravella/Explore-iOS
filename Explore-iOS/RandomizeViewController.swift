//
//  ViewController.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/21/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class RandomizeViewController: UIViewController, YelpTableViewControllerDelegate {
    
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var bucketListButton: UIButton!
    
    var navCon: NavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setup(button: randomizeButton)
        setup(button: bucketListButton)
    }
    
    func setup(button: UIButton) {
        button.layer.cornerRadius = button.frame.height/4
    }
    
    func setupNavigationController() {
        navigationItem.title = "Explore"
    }

    @IBAction func randomizeButtonPressed(_ sender: Any) {
        //** TESTING CODE HERE **//
        
        var yelpBusinessArray: [YelpBusiness] = []
        for _ in 0..<10 {
            let business = YelpBusiness();
            yelpBusinessArray.append(business)
        }
        
        //Yelp Call Here
        YelpClient.sharedInstance.searchYelpBusinesses(withLocation: "35-Crescent-St-Waltham-MA") { result in
            switch result {
            case .Success(let businesses):
                guard let yelpVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "yelpTableVC") as? YelpTableViewController,
                    let businesses = businesses as? [YelpBusiness] else {return}
                yelpVC.yelpBusinessArray = businesses
                yelpVC.delegate = self
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(yelpVC, animated: true)
                }
                break
            case .Failure(let error):
                print(error)
                break
            }
            
        }
    }
    
    func didRequestToDismissYelpViewController(sender: UIViewController) {
        let _ = navigationController?.popViewController(animated: true)
    }
}
