//
//  SignUpViewController.swift
//  baseProject
//
//  Created by Eric on 8/12/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements() {
        self.errorLabel.alpha = 0
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signupButton)
    }
    
    func validateFields() -> String? {
        //check if fields are populated and password is valid.  if all ok, return nil otherwise error message as string
        
        //check all fields are populatd
        if self.firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  ||
            self.lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        } /* else {
            
            //have data in all the fields
            //is password valid
            let cleanedPassword = passwordTextField.text!
            
            if Utilities.isPasswordValid(cleanedPassword) == false {
                //bad password
                return "Your password is not secure.  Please make sure you use 8 characters, a special character and a number"
            }
         
            
        } */
        
        return nil
    }
    
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        
        //validate fields
        let error = validateFields()
        
        if error != nil {
            //there was an error
            showError(error!)
        } else {
            //create clean versions of fields
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = self.lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password ) { (result, err) in
                if let err = err {
                    //error
                    self.showError(err.localizedDescription)
                } else {
                    self.showError("User was created.  Building user profile")
                    
                    let db = Firestore.firestore()
               
                    db.collection("users").addDocument(data: [
                        "firstname": firstname,
                        "lastname": lastname,
                        "UID": result!.user.uid
                    
                    ]) { (err) in
                        if err != nil {
                            //didnt write to database
                            self.showError(err!.localizedDescription)
                        }
                    }
                    //user created and profile stored
                    self.transitionToHome()
                }
            }
        }
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
