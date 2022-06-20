//
//  ViewController.swift
//  ToDolListCoreData
//
//  Created by Карим Садыков on 19.06.2022.
//

import UIKit
import CoreData

class CheckListViewController: UITableViewController {

    var checkList = [Checklist]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCheckList()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Checklist(context: self.context)
            newCategory.name = textField.text!
            self.checkList.append(newCategory)
            self.saveCheckList()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = checkList[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "item", sender: self)
    }
    
    
    //MARK: - TableView Delegate Methods
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "item" {
            let itemVC = segue.destination as! ItemViewController
            if let index = tableView.indexPathForSelectedRow?.row {
                itemVC.checklist = checkList[index]
            }
//            let destinationVC = segue.destination as! ItemViewController
//            if let index = tableView.indexPathForSelectedRow?.row {
//                destinationVC.checklist = checkList[index]
//
//            }
        }
        
    }
    
    //MARK: - Saving and loading data methods
    
    func saveCheckList() {
        
        do {
            try context.save()
        } catch  {
            print("Error saving category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCheckList() {
        
        let request : NSFetchRequest<Checklist> = Checklist.fetchRequest()
        
        do {
            checkList = try context.fetch(request)
        } catch  {
            print("Error loading categories \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - Swipe actions - delete and edit
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let category = checkList[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            
            self.context.delete(category)
            self.checkList.remove(at: indexPath.row)
            self.saveCheckList()
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            
            let alert = UIAlertController(title: "Edit", message: "", preferredStyle: .alert)
            
            var textField = UITextField()
            
            alert.addTextField { (alertTextField)  in
                textField = alertTextField
                textField.text = category.name
                
            }
            
            let updateAction = UIAlertAction(title: "Save", style: .default) { action in
                
                self.checkList[indexPath.row].name = textField.text
                self.saveCheckList()
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(updateAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
            
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return swipeActions

    }

}
