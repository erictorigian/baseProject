//
//  HomeTableViewController.swift
//  baseProject
//
//  Created by Eric on 8/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HomeTableViewController: UITableViewController {

    var accomplishments = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        let db = Firestore.firestore()
        
        db.collection("accomplishments").getDocuments() { (snapshot, err) in
            
            if let err = err {
                print("error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let accomplishment = document.data()
                    self.accomplishments.append(accomplishment["accomplishment"] as! String)
                    print(accomplishment)
                    self.tableView.reloadData()
                }
                
            }
        }
                
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accomplishments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.accomplishments[indexPath.row]
        return cell
    }

}
