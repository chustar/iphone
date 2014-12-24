//
//  FirstViewController.swift
//  Todo List
//
//  Created by Chuma Nnaji on 12/15/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

var todoItems: [String] = []

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = todoItems[indexPath.row]
        return cell
    }

    override func viewWillAppear(animated: Bool) {
        if var storedItems: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("toDo") {
            todoItems = []
            for var i = 0; i < storedItems.count; i++ {
                todoItems.append(storedItems[i] as NSString)
            }
        }
        table?.reloadData()
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todoItems.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(todoItems, forKey: "toDo")
            NSUserDefaults.standardUserDefaults().synchronize()
            table?.reloadData()
        }
    }

}

