//
//  SecondViewController.swift
//  Todo List
//
//  Created by Chuma Nnaji on 12/15/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var todoItem: UITextField!

    @IBAction func addItem(sender: AnyObject) {
        todoItems.append(todoItem.text)
        NSUserDefaults.standardUserDefaults().setObject(todoItems, forKey: "toDo")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}

