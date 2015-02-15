//
//  TinderViewController.swift
//  Tinder
//
//  Created by Chuma Nnaji on 2/12/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class TinderViewController: UIViewController
{

    var xFromCenter: CGFloat = 0
    var userNames: [String] = []
    var userImages: [NSData] = []
    var targetUser = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()

        PFGeoPoint.geoPointForCurrentLocationInBackground
        {
            (geoPoint: PFGeoPoint!, error: NSError!) -> Void in
            if error == nil
            {
                var currentUser = PFUser.currentUser()
                currentUser["location"] = geoPoint

                var query = PFUser.query()
                query.whereKey("location", nearGeoPoint: geoPoint)
                query.limit = 10
                query.findObjectsInBackgroundWithBlock(
                {
                    (users, error) -> Void in
                    if error == nil
                    {
                        for user in users
                        {
                            if user["gender"] as String == currentUser["interestedIn"] as NSString
                                && user.username != currentUser.username
                            {
                                self.userNames.append(user.username)
                                self.userImages.append(user["image"] as NSData)
                            }
                        }

                        self.createImage(UIImage(data: self.userImages[0])!)
                    }
                })
                currentUser.save()
            }
        }
    }

    func wasDragged(gesture: UIPanGestureRecognizer)
    {
        var imageView = gesture.view!

        let translation = gesture.translationInView(self.view)
        imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y + translation.y)
        gesture.setTranslation(CGPointZero, inView: self.view)

        xFromCenter += translation.x
        var rotation: CGAffineTransform = CGAffineTransformMakeRotation(xFromCenter / 200)
        var scaleAmount = min(50/abs(xFromCenter), 1)
        var scale: CGAffineTransform = CGAffineTransformScale(rotation, scaleAmount, scaleAmount)
        imageView.transform = scale

        if imageView.center.x < 100
        {
            println("Not chosen")
        }
        else if imageView.center.x > self.view.bounds.width - 100
        {
            println("Chosen")
        }

        if gesture.state == UIGestureRecognizerState.Ended
        {
            imageView.removeFromSuperview()

            self.targetUser++
            if self.targetUser < self.userImages.count
            {
                xFromCenter = 0
                createImage(UIImage(data: userImages[self.targetUser])!)
            }
            else
            {
                println("No more users")
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createImage(image: UIImage)
    {
        var userImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        userImage.image = image
        userImage.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(userImage)

        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        userImage.addGestureRecognizer(gesture)
        userImage.userInteractionEnabled = true
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
