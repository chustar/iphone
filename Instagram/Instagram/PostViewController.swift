//
//  PostViewController.swift
//  Instagram
//
//  Created by Chuma Nnaji on 1/17/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var photoSelected: Bool = false

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))

    @IBOutlet weak var imageToPost: UIImageView!

    @IBOutlet weak var shareText: UITextField!

    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logout", sender: self)
    }

    @IBAction func chooseImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false

        self.presentViewController(image, animated: true, completion: nil)
    }

    @IBAction func postImage(sender: AnyObject) {
        var error: String = ""
        if photoSelected == false {
            error = "Please select a photo"
        } else if shareText.text == "" {
            error = "Please enter a message"
        }

        if error != "" {
            displayAlert("Cannot post image", error: error)
        } else {
            displayActivityIndicator()

            var post = PFObject(className: "post")
            post["title"] = shareText.text
            post["username"] = PFUser.currentUser().username
            post.saveInBackgroundWithBlock({
                (success: Bool!, error: NSError!) -> Void in
                if success == false {
                    self.dismissActivityIndicator()
                    self.displayAlert("Failed to post image", error: "Please try again later")
                } else {
                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    post["imageFile"] = imageFile

                    post.saveInBackgroundWithBlock({
                        (success: Bool!, error: NSError!) -> Void in

                        self.dismissActivityIndicator()

                        if success == false {
                            self.displayAlert("Failed to post image", error: "Please try again later")
                        } else {
                            self.photoSelected = false
                            self.imageToPost.image = UIImage(named: "billg.png")
                            self.shareText.text = ""
                            self.displayAlert("Image Posted", error: "Image has been posted successfully")
                           println("success")
                            
                        }
                    })

                }
            })
        }
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageToPost.image = image
        photoSelected = true

        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        photoSelected = false
        imageToPost.image = UIImage(named: "billg.png")
        shareText.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func displayAlert(title: String, error: String) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
            action in
            //            self.dismissViewControllerAnimated(true, completion: nil)
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
