//
//  ViewController.swift
//  CatYears
//
//  Created by Chuma Nnaji on 11/30/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var catAge: UITextField!
    @IBOutlet weak var displayLabel: UILabel!

    @IBAction func calculateButton(sender: AnyObject) {
        let catAgeVal: Int = catAge.text.toInt()!
        displayLabel?.text = "\(catAgeVal) cat years old"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

