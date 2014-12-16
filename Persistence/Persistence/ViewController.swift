//
//  ViewController.swift
//  Persistence
//
//  Created by Chuma Nnaji on 12/15/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        NSUserDefaults.standardUserDefaults().setValue("Rob", forKey: "myName")
//
//        NSUserDefaults.standardUserDefaults().synchronize() //saves values permanently

        println(NSUserDefaults.standardUserDefaults().objectForKey("myName"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

