//
//  Login.swift
//  Explore-iOS
//
//  Created by Kiley Caravella on 3/27/17.
//  Copyright © 2017 kileycaravella. All rights reserved.
//

import UIKit

enum NavigateText:String {
    case Login = "Log In"
    case SignUp = "Join the Family"
    case ForgotPassword = "Forgot Password"
    case Unknown = ""
}

class LoginViewController: GeneralNibDelegateViewController {
    
    //MARK: - Variables
    
    @IBOutlet weak var nibView: UIView!
    @IBOutlet weak var nibViewConstraint: NSLayoutConstraint!
    
    var mainStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var navController: NavigationController?
    var currentNib: NavigateText = .Login
    let slideCustomAnimationController = SlideCustomAnimationController()

    //MARK: - Setup for View
    
    override func viewWillAppear(_ animated: Bool) {
        guard let loginNib = setup(nibwithName: "ResetPasswordNib") as? GeneralNibView else { return }
        loginNib.alpha = 1
        loginNib.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navController = navigationController as? NavigationController
        navController?.delegate = self
    }
    
    func setup(nibwithName name: String) -> UIView {
        guard let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? UIView else { return UIView() }
        nibView.addSubview(nib)
        nib.alpha = 0
        nib.frame.size.width = nibView.frame.width
        nib.frame.origin = CGPoint(x:0, y:0)
        return nib
    }
    
    func setup(textField: UITextField) {
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10.0
    }
    
    //MARK: - Navigating Between Nib Views
    
    @IBAction func navigateButtonPressed(_ sender: UIButton) {
        guard let navigateText = sender.titleLabel?.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        sender.setTitle(currentNib.rawValue, for: .normal)
        
        var nibName: String
        switch(navigateText) {
        case NavigateText.Login.rawValue:
            currentNib = .Login
            nibName = "LoginNib"
            break
        case NavigateText.SignUp.rawValue:
            currentNib = .SignUp
            nibName = "SignUpNib"
            break
        case NavigateText.ForgotPassword.rawValue:
            currentNib = .ForgotPassword
            nibName = "ForgotPasswordNib"
            break
        default:
            currentNib = .Unknown
            nibName = ""
            break
        }
        
        guard let nextNib: GeneralNibView = setup(nibwithName: nibName) as? GeneralNibView else { print("bad"); return }
        nextNib.delegate = self
        animateNibTransition(fromNib: nibView.subviews.first, toNib: nextNib)
    }
    
    func animateNibTransition(fromNib: UIView?, toNib: GeneralNibView) {
        guard let fromNib = fromNib else { return }
        UIView.animate(withDuration: 0.3, animations: {
            fromNib.alpha = 0.2
            
            self.nibViewConstraint.constant = toNib.frame.height
            toNib.frame.size.height = self.nibView.frame.height
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                fromNib.alpha = 0
                toNib.alpha = 1
            })
            fromNib.removeFromSuperview()
        })
    }
    
    //MARK: - Logging into Application
    
    
    //MARK: - GeneralNibDelegateViewController overrides
    
    override func didGetSuccessfulLoginResult(sender: LoginNib) {
        pushRandomizeViewController()
    }
    
    //MARK: - SignUpNibDelegate
    
    override func didSuccessfullySignUp(sender: SignUpNib) {
        guard let nextNib: GeneralNibView = setup(nibwithName: "ConfirmSignUpNib") as? GeneralNibView else { return }
        nextNib.delegate = self
        animateNibTransition(fromNib: nibView.subviews.first, toNib: nextNib)
    }
    
    override func didSuccessfullyConfirmAccount(sender: ConfirmSignUpNib) {
        pushRandomizeViewController()
    }
    
    override func didSuccessfullySendAuthEmail(sender: ForgotPasswordNib) {
        guard let nextNib: GeneralNibView = setup(nibwithName: "ResetPasswordNib") as? GeneralNibView else { return }
        nextNib.delegate = self
        animateNibTransition(fromNib: nibView.subviews.first, toNib: nextNib)
    }
    
    override func didSuccessfullyResetPassword(sender: ResetPasswordNib) {
        pushRandomizeViewController()
    }
    
    func pushRandomizeViewController() {
        
        let randomizeVC = mainStoryboard.instantiateViewController(withIdentifier: "randomizeVC")
        randomizeVC.navigationItem.hidesBackButton = true
        slideCustomAnimationController.directionX = .Right
        navController?.pushViewController(randomizeVC, animated: true)
    }
}

// MARK: - View Controller Transition

extension LoginViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slideCustomAnimationController
    }
}
