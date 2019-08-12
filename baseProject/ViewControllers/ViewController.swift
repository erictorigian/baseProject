//
//  ViewController.swift
//  baseProject
//
//  Created by Eric on 8/11/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupElements()

    }
    
    func setupElements() {
        Utilities.styleHollowButton(signupButton)
        Utilities.styleFilledButton(loginButton)
    }


}

