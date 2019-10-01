//
//  ViewController.swift
//  Todoey
//
//  Created by Karl Jay on 9/30/19.
//  Copyright © 2019 KarlJay. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    // temp data array
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // just in case the defaults array isn't there
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }

    }

    // MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        var myNewField =  UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Add Item", style: .default) { (action) in

            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
            print(textField.text ?? "Default Value")
            print(myNewField.text ?? "Default Value")
            print("Add Item Pressed")
            print(self.itemArray)
        }
        let action2 = UIAlertAction(title: "Cancel Item", style: .cancel) { (action) in
            print(textField.text ?? "Default Value")
            print(myNewField.text ?? "Default Value")
            print("Cancel Item Pressed")
        }
        /*
        let action3 = UIAlertAction(title: "Third Option", style: .default) { (action) in
            print(textField.text ?? "Default Value")
            print(myNewField.text ?? "Default Value")
            print("Third Item Pressed")
        }
         */
        
        // how does textField get set when control is clearly OUT of this block?
        // does textField assume a pointer to alertTextField and is set OUTSIDE the block?
        // if so, can't other vars be set inside of a block when the var inside the block is nil?
        
        alert.addTextField {  (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print("textField is:", textField)
            print(alertTextField.text!)
        }
        // simple test to see how to do several field in an alert
        alert.addTextField {  (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            myNewField = alertTextField
            print("textField is:", myNewField)
            print(alertTextField.text!)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        //alert.addAction(action3)

        present(alert, animated: true, completion: nil)
    }
        
}

