//
//  CategoryViewController.swift
//  Todey
//
//  Created by arjun on 13/08/18.
//  Copyright © 2018 ArjunSinghTalwar. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var CategoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(dataFilePath)
        loadItem()
    }

  

    // MARK: - Table view data source

   

    

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        let item = CategoryArray[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray.count
    }
 

   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
//           print(textfield)
            let newCategory = Category(context: self.context)
            newCategory.name = textfield.text
            self.CategoryArray.append(newCategory)
            
            self.saveData()
           
        }
        alert.addAction(action)
        
        alert.addTextField { (alertextfield) in
            alertextfield.placeholder = "Create New Item"
            textfield = alertextfield
        }
        present(alert, animated: true, completion: nil)
    }
    
    // Mark- table delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodeyItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectCategory = CategoryArray[indexPath.row]
        }
    }
    //Mark-manupulation of data
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItem(with request : NSFetchRequest<Category> = Category.fetchRequest()){
     
        do{
            CategoryArray = try context.fetch(request)
        }
        catch{
            print("Error in fetching  item\(error)")
            
        }
        tableView.reloadData()
    }
    
}
