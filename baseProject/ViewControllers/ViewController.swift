//
//  ViewController.swift
//  baseProject
//
//  Created by Eric on 8/11/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkForAuthenticatedUser()
        setupElements()

    }
    
    func checkForAuthenticatedUser() {
        if Auth.auth().currentUser?.uid != nil {
            //user is logged in; go to home
            self.transitionToHome()
        }
    }
    
    func setupElements() {
        Utilities.styleHollowButton(signupButton)
        Utilities.styleFilledButton(loginButton)
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }


}

