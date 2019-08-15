//
//  HomeTableViewController.swift
//  baseProject
//
//  Created by Eric on 8/15/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var accomplishments = [Accomplishment]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.accomplishments.append(Accomplishment(detail: "wrote a custom class"))
        
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
        cell.textLabel?.text = accomplishments[indexPath.row].detail
        return cell
    }

}
