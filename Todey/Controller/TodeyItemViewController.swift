//
//  ViewController.swift
//  Todey
//
//  Created by arjun on 21/07/18.
//  Copyright © 2018 ArjunSinghTalwar. All rights reserved.
//

import UIKit

class TodeyItemViewController: UITableViewController {

   // var itemArrary = ["Buy Milk","Buy Apple","Buy Juice"]
    var itemArrary = [Item]()
  
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let newItem = Item()
        newItem.title = "Buy Milk"
        itemArrary.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Apple"
        itemArrary.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy Juice"
        itemArrary.append(newItem3)
      
        if let items = defaults.array(forKey: "TodoeyListArrary") as? [Item]{
            itemArrary = items
        }
    }
  
    // Mark - Tableview DataSource Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodeyItemCell", for: indexPath)
       
        let item = itemArrary[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArrary.count
    }
    // Mark - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArrary[indexPath.row])
        
        itemArrary[indexPath.row].done = !itemArrary[indexPath.row].done
        
//        if itemArrary[indexPath.row].done == false {
//            itemArrary[indexPath.row].done = true
//        }else{
//            itemArrary[indexPath.row].done = false
//        }
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //Mark - Alert add button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle:.alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happen when user click on add button on our UIalert
//            print(textfield.text!)
            
            let newItem = Item()
            
           
            newItem.title = textfield.text!
            self.itemArrary.append(newItem)
            
            self.defaults.set(self.itemArrary, forKey: "TodoeyListArrary")
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

