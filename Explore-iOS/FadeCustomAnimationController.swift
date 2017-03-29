//
//  SlideCustomAnimationController.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/28/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

class FadeCustomAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var reverse: Bool = false

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toView = toViewController.view,
            let fromView = fromViewController.view
            else { return }

        toView.alpha = 0
        containerView.backgroundColor = .white
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0
            toView.alpha = 1
        }, completion: { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}
