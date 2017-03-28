//
//  YelpTableViewCell.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/21/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class YelpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func populateCells(withBusiness business: YelpBusiness) {
        nameLabel.text = business.name
        var addressString = ""
        for address in business.location.displayAddress {
            addressString += address + " "
        }
        addressLabel.text = addressString
        
        phoneButton.setTitle(business.displayPhone, for: UIControlState.normal)
        distanceLabel.text = String(format: "%.2f", business.distance) + " miles"
        
        setYelpRating(rating: business.rating)
        guard let imageURL = URL(string: business.imageURL) else {return}
        downloadMainImage(url: imageURL)
    }
    
    private func downloadMainImage(url: URL) {
        getData(fromURL: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func getData(fromURL url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    private func setYelpRating(rating: Double) {
        switch(rating) {
        case 0.5: //YELP ERROR: - Yelp does not return a half-star review image so we are rounding up.
            ratingImageView.image = UIImage(named: "small_1")
            break
        case 1.0:
            ratingImageView.image = UIImage(named: "small_1")
            break
        case 1.5:
            ratingImageView.image = UIImage(named: "small_1_half")
            break
        case 2.0:
            ratingImageView.image = UIImage(named: "small_2")
            break
        case 2.5:
            ratingImageView.image = UIImage(named: "small_2_half")
            break
        case 3.0:
            ratingImageView.image = UIImage(named: "small_3")
            break
        case 3.5:
            ratingImageView.image = UIImage(named: "small_3_half")
            break
        case 4.0:
            ratingImageView.image = UIImage(named: "small_4")
            break
        case 4.5:
            ratingImageView.image = UIImage(named: "small_4_half")
            break
        case 5.0:
            ratingImageView.image = UIImage(named: "small_5")
            break
        default:
            ratingImageView.image = UIImage(named: "small_0")
            break
        }
    }
}
