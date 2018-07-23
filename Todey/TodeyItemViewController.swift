//
//  ViewController.swift
//  Todey
//
//  Created by arjun on 21/07/18.
//  Copyright © 2018 ArjunSinghTalwar. All rights reserved.
//

import UIKit

class TodeyItemViewController: UITableViewController {

    var itemArrary = ["Buy Milk","Buy Apple","Buy Juice"]
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
    //Mark - Alert add button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle:.alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happen when user click on add button on our UIalert
//            print(textfield.text!)
            self.itemArrary.append(textfield.text!)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        
        alert.addTextField { (alertextfield) in
            alertextfield.placeholder = "Create New Item"
            textfield = alertextfield
        }
       
        present(alert, animated: true, completion: nil)
    }
    
}

