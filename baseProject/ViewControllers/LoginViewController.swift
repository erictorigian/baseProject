//
//  LoginViewController.swift
//  baseProject
//
//  Created by Eric on 8/12/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    var window: UIWindow?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
    }
    
    func setupElements() {
        self.errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    func validateFields() -> String? {
        //check if fields are populated and password is valid.  if all ok, return nil otherwise error message as string
        
        //check all fields are populatd
        if self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        //validate text fields
        let error = validateFields()
        if error != nil {
            //error on the form
            showError(error!)
        } else {
            //sign in the user
            let email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError(err!.localizedDescription)
                } else {
                    self.transitionToHome()
                }
            }
            
        }
        
        
        //transition to home scrren
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
}
