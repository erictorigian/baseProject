//
//  NewAccomplishmentViewController.swift
//  baseProject
//
//  Created by Eric on 8/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class NewAccomplishmentViewController: UIViewController {
    
    var accomplishment = [Accomplishment]()
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var accomplishmentDetailsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if let accomplishmentDetail = accomplishmentDetailsTextField.text {
            let newDetail = accomplishmentDetail
            let newUser = "Eric"
            
            let newAccomplishment = Accomplishment(detail: newDetail, user: newUser)
            
            let db = Firestore.firestore()
            
            db.collection("accomplishments").addDocument(data: [
                "accomplishment": newAccomplishment.detail,
                "user": newAccomplishment.user ])
            
            navigationController?.popViewController(animated: true)
        }
    }
}
