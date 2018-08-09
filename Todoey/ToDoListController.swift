//
//  ViewController.swift
//  Todoey
//
//  Created by David  on 8/9/18.
//  Copyright © 2018 David Huang. All rights reserved.
//

import UIKit

class ToDoListController : UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }


    //TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        if let selectedCell = tableView.cellForRow(at: indexPath){
            selectedCell.accessoryType = selectedCell.accessoryType == .checkmark ? .none : .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add To Do Item", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "To Do Item"
        }
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            if let item = alert.textFields![0].text, !item.isEmpty{
                self.tableView.beginUpdates()
                self.itemArray.append(item)
                self.tableView.insertRows(at: [IndexPath(row: self.itemArray.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
                self.tableView.endUpdates()
                self.tableView.reloadD
            }else{
                let emptyAlert = UIAlertController(title: "Error", message: "Cannot add an empty item!", preferredStyle: .alert)
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                    emptyAlert.dismiss(animated: true, completion: {
                        self.present(alert, animated: true, completion: nil)
                    })
                })
               self.present(emptyAlert, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

