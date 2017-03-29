//
//  UIView+LoadNib.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/29/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

extension UIView {
    
    public class func fromNib() -> Self {
        return fromNib()
    }
    
    public func fromNib(nibName: String = "") -> UIView {
        if nibName.isEmpty {
            return UIView()
        }
        
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
}
