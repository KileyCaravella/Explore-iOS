//
//  YelpViewController.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/21/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

protocol YelpViewControllerDelegate: class {
    func didRequestToDismissYelpViewController(sender: UIViewController)
}

class YelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var yelpTableView: UITableView!
    
    var yelpBusinessArray: [YelpBusiness] = []
    var delegate: YelpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        yelpBusinessArray.sort{$0.distance < $1.distance}
    }
    
    func setupTableView() {
        yelpTableView.delegate = self
        yelpTableView.dataSource = self
        yelpTableView.backgroundColor = UIColor(red: 200/255, green: 195/255, blue: 200/255, alpha: 1.0)
        yelpTableView.register(UINib(nibName: "YelpTableViewCell", bundle: nil), forCellReuseIdentifier: "yelpCell")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.didRequestToDismissYelpViewController(sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return yelpBusinessArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "yelpCell", for: indexPath) as? YelpTableViewCell else {return UITableViewCell()}
        cell.populateCells(withBusiness: yelpBusinessArray[indexPath.section])
        cell.backgroundColor = UIColor(red: 220/255, green: 215/255, blue: 220/255, alpha: 1.0)
        return cell
    }
}
