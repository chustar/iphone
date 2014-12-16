//
//  SecondViewController.swift
//  Tabbed App
//
//  Created by Chuma Nnaji on 12/15/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        println("Second view loaded")
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("Second view shown")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

