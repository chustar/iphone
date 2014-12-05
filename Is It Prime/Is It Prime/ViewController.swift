//
//  ViewController.swift
//  Is It Prime
//
//  Created by Chuma Nnaji on 12/4/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var number: UITextField!

    @IBOutlet weak var message: UILabel!

    @IBAction func buttonPressed(sender: AnyObject) {
        var isPrime: Bool = true

        if let numberVal: Int = number.text.toInt() {
            if numberVal < 1 {
                message.text = "Please enter a positive number"
            } else {
                if numberVal == 1 {
                    message.text = "1 is not a prime number"
                } else {
                    for i in 2..<numberVal {
                        if numberVal % i == 0 {
                            isPrime = false
                            break
                        }
                    }

                    if isPrime {
                        message.text = "\(numberVal) is a prime number"
                    } else {
                        message.text = "\(numberVal) is not a prime number"
                    }
                }
            }
        } else {
            message.text = "Please enter a number"
        }

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

