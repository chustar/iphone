//
//  ViewController.swift
//  Instagram
//
//  Created by Chuma Nnaji on 1/12/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var signUpActive = true

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))

    @IBOutlet weak var alreadyRegisteredLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!

    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var toggleSignUpButton: UIButton!
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!

    @IBAction func toggleSignUp(sender: AnyObject) {
        if signUpActive == true {
            signUpActive = false
            signUpLabel.text = "User the form below to log in"
            signUpButton.setTitle("Log In", forState: UIControlState.Normal)
            alreadyRegisteredLabel.text = "Not Registered?"
            toggleSignUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
        } else {
            signUpActive = true
            signUpLabel.text = "User the form below to sign up"
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            alreadyRegisteredLabel.text = "Already Registered?"
            toggleSignUpButton.setTitle("Log In", forState: UIControlState.Normal)
        }
    }

    @IBAction func signUp(sender: AnyObject) {
        var error = ""
        if username.text == "" || password.text == "" {
            error = "Please enter a username and password"
        } else if countElements(password.text) < 6 {
            error = "Please use a password that's at least 6 characters long"
        }

        if error != "" {
            displayAlert("Error", error: error)
        } else {
            var user = PFUser()
            user.username = username.text
            user.password = password.text

            displayActivityIndicator()

            if signUpActive == true {
                user.signUpInBackgroundWithBlock({
                    (succeded: Bool!, signUpError: NSError!) -> Void in
                    self.dismissActivityIndicator()

                    if signUpError == nil {
                        self.performSegueWithIdentifier("jumpToUserTable", sender: self)
                    } else {
                        if let errorString = signUpError.userInfo?["error"] as? NSString {
                            error = errorString
                        } else {
                            error = "Please try again later"
                        }

                        self.displayAlert("Could not sign up", error: error)
                    }
                })
            } else {
                PFUser.logInWithUsernameInBackground(username.text, password: password.text, {
                    (user: PFUser!, signInError: NSError!) -> Void in
                    self.dismissActivityIndicator()

                    if signInError == nil {
                        self.performSegueWithIdentifier("jumpToUserTable", sender: self)
                    } else {
                        if let errorString = signInError.userInfo?["error"] as? NSString {
                            error = errorString
                        } else {
                            error = "Please try again later"
                        }

                        self.displayAlert("Could not log in", error: error)
                    }
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("jumpToUserTable", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    func displayAlert(title: String, error: String) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func displayActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }

    func dismissActivityIndicator() {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
}

