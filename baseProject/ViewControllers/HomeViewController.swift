//
//  HomeViewController.swift
//  baseProject
//
//  Created by Eric on 8/12/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let user = Auth.auth().currentUser
    var accomplishments = [Accomplishment]()
    let db = Firestore.firestore().collection("accomplishments")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        db.addSnapshotListener { (snapshot, err) in
            guard err == nil else {
                print(err!.localizedDescription)
                return
            }
            self.accomplishments = []
            
            //have good read from database
            for document in snapshot!.documents {
                let accomplishment = document.data()
                print("accomplishment: \(accomplishment)")
                let newDetail = accomplishment["accomplishment"] as! String? ?? "Default"
                let newUser = accomplishment["user"] as! String? ?? "Default"
                
                let newAccomplishment = Accomplishment(detail: newDetail , user: newUser )
                
                self.accomplishments.append(newAccomplishment)
                
                self.tableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accomplishments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = accomplishments[indexPath.row].detail
        cell.detailTextLabel?.text = accomplishments[indexPath.row].user
        return cell
    }
    
    
    
}
