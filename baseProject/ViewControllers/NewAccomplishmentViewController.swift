//
//  NewAccomplishmentViewController.swift
//  baseProject
//
//  Created by Eric on 8/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import FirebaseFirestore

class NewAccomplishmentViewController: UIViewController {
    
    var accomplishment = Accomplishment()

    @IBOutlet weak var accomplishmentDetailsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if let accomplishmentDetail = accomplishmentDetailsTextField.text {
            
            self.accomplishment.detail = accomplishmentDetail
            
            let db = Firestore.firestore()
            
            db.collection("accomplishments").addDocument(data: ["accomplishment": accomplishmentDetail])
            
            navigationController?.popViewController(animated: true)
        }
    }
}
