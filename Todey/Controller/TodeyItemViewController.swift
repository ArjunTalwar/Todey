//
//  ViewController.swift
//  Todey
//
//  Created by arjun on 21/07/18.
//  Copyright © 2018 ArjunSinghTalwar. All rights reserved.
//

import UIKit
import CoreData
class TodeyItemViewController: UITableViewController {

   // var itemArrary = ["Buy Milk","Buy Apple","Buy Juice"]
    var itemArrary = [Item]()
    var selectCategory : Category?{
        didSet{
            loadItem()
        }
        
    }
//    for userDefault
//    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
//        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Buy Milk"
//        itemArrary.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Apple"
//        itemArrary.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Buy Juice"
//        itemArrary.append(newItem3)
      
//        if let items = defaults.array(forKey: "TodoeyListArrary") as? [Item]{
//            itemArrary = items
//        }
      
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
//        context.delete(itemArrary[indexPath.row])
//        itemArrary.remove(at: indexPath.row)
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
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //Mark - Alert add button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle:.alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happen when user click on add button on our UIalert
//            print(textfield.text!)
            
            let newItem = Item(context: self.context)
            newItem.title = textfield.text!
            newItem.done = false
            newItem.parentCategory = self.selectCategory
            self.itemArrary.append(newItem)
            
//            self.defaults.set(self.itemArrary, forKey: "TodoeyListArrary")
            self.saveItems()
        }
        alert.addAction(action)
        
        alert.addTextField { (alertextfield) in
            alertextfield.placeholder = "Create New Item"
            textfield = alertextfield
        }
       
        present(alert, animated: true, completion: nil)
    }
    
    //Mark- model Manupulation Method
    
    func saveItems(){
//        let encoder = PropertyListEncoder()
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest(),predicate: NSPredicate? = nil){
//                for decoder part
//            if  let data = try? Data(contentsOf: dataFilePath!){
//               let decoder = PropertyListDecoder()
//                do{
//                itemArrary = try decoder.decode([Item].self, from: data)
//                }
//                catch{
//                    print("Error decoder item\(error)")
//                }
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectCategory!.name!)
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        } else{
            request.predicate = categoryPredicate
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
//
//        request.predicate = compoundPredicate
        do{
            itemArrary = try context.fetch(request)
        }
        catch{
        print("Error in fetching  item\(error)")
            
        }
        tableView.reloadData()
    }
   
}
extension TodeyItemViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
       
        
        
        loadItem(with: request,predicate: predicate)
//        do{
//            itemArrary = try context.fetch(request)
//        }
//        catch{
//            print("Error in fetching  item\(error)")
//
//        }
//        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            
            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
        }
    }
}

