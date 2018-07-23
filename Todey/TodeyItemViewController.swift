//
//  ViewController.swift
//  Todey
//
//  Created by arjun on 21/07/18.
//  Copyright © 2018 ArjunSinghTalwar. All rights reserved.
//

import UIKit

class TodeyItemViewController: UITableViewController {

    let itemArrary = ["Buy Milk","Buy Apple","Buy Juice"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // Mark - Tableview DataSource Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodeyItemCell", for: indexPath)
        cell.textLabel?.text = itemArrary[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArrary.count
    }
    // Mark - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArrary[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
      
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

