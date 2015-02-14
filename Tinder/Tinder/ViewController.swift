//
//  ViewController.swift
//  Tinder
//
//  Created by Chuma Nnaji on 2/4/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginFailedLabel: UILabel!
    @IBAction func signIn(sender: AnyObject) {
        self.loginFailedLabel.alpha = 0
        var permissions = ["public_profile"]
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                self.loginFailedLabel.alpha = 1
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")

                self.performSegueWithIdentifier("signUp", sender: self)
            } else {
                NSLog("User logged in through Facebook!")
                // Redirect to the main Tinder page.
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if PFUser.currentUser() != nil {
            println("User logged in")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

