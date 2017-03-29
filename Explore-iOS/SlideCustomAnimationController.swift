//
//  ScrollCustomAnimationController.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/29/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

enum XDirection: CGFloat {
    case Right = 1
    case Left = -1
    case Neither = 0
}

enum YDirection: CGFloat {
    case Up = 1
    case Down = -1
    case Neither = 0
}

class SlideCustomAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var directionX: XDirection = .Neither
    var directionY: YDirection = .Neither
    var wantAnimation = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else { transitionContext.completeTransition(true); return }
        
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        
        let bounds = UIScreen.main.bounds
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: bounds.size.width * directionX.rawValue, dy: bounds.size.height * directionY.rawValue)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: nil), animations: {
            
            fromViewController.view.frame.origin.x -= fromViewController.view.frame.width * self.directionX.rawValue
            fromViewController.view.frame.origin.y -= fromViewController.view.frame.width * self.directionY.rawValue
            toViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(true)
            fromViewController.removeFromParentViewController()
        })
    }
}
