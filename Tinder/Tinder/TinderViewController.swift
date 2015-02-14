//
//  TinderViewController.swift
//  Tinder
//
//  Created by Chuma Nnaji on 2/12/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class TinderViewController: UIViewController {

    var xFromCenter: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint!, error: NSError!) -> Void in
            if error == nil {
                println(geoPoint)

                var user = PFUser.currentUser()
                user["location"] = geoPoint
                user.save()
            }
        }

        /*
        func addPerson(urlString: String) {
            let urlRequest: NSURLRequest = NSURLRequest(URL: NSURL(string: urlString)!)
            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
                response, data, error in

                var newUser = PFUser()
                newUser["image"] = data
                newUser["gender"] = rand() % 2 == 0 ? "male" : "female"
                newUser["username"] = "user_\(rand() % 100)"
                newUser.password = "password"
                var location = PFGeoPoint(latitude: Double(37 + rand() % 20), longitude: Double(-122 + rand() % 20))
                newUser["location"] = location
                newUser.signUp()
            })
        }

        addPerson("https://3.googleusercontent.com/-Nw_kkLgPSTU/AAAAAAAAAAI/AAAAAAAAIro/UcKx1NcaXvY/s160-c-k-no/photo.jpg")
        addPerson("https://5.googleusercontent.com/-7o4IH7LO1_0/AAAAAAAAAAI/AAAAAAAAAAA/96TwdZGmqGs/s160-c-k-no/photo.jpg")
        addPerson("https://5.googleusercontent.com/-XI4jZo-OFaw/AAAAAAAAAAI/AAAAAAAAAZs/5f9lmMVwTug/s160-c-k-no/photo.jpg")
        addPerson("https://3.googleusercontent.com/-CjDC-WSFsTU/AAAAAAAAAAI/AAAAAAAAA9M/_mFTZE-w2F0/s160-c-k-no/photo.jpg")
        addPerson("https://3.googleusercontent.com/-XUnyaVoreT8/AAAAAAAAAAI/AAAAAAAAAAA/YXRzlCifPKM/s160-c-k-no/photo.jpg")
        addPerson("https://6.googleusercontent.com/-JeQ7DzreBgU/AAAAAAAAAAI/AAAAAAAAAMc/FTS2z82Y0PU/s160-c-k-no/photo.jpg")
        addPerson("https://5.googleusercontent.com/-XgdRr6PdTyo/AAAAAAAAAAI/AAAAAAAAAGs/nM643SLImjU/s160-c-k-no/photo.jpg")
        addPerson("https://3.googleusercontent.com/-C5TrsIqCU2A/AAAAAAAAAAI/AAAAAAAAC7o/DTQdthyDiaM/s160-c-k-no/photo.jpg")
        addPerson("https://6.googleusercontent.com/-H-oD42VkNNo/AAAAAAAAAAI/AAAAAAAAAE8/7CGY-Iz5Trw/s160-c-k-no/photo.jpg")
        addPerson("https://3.googleusercontent.com/-OzZcEvVuh4Y/AAAAAAAAAAI/AAAAAAAAAAA/zJTMLSpMODg/s160-c-k-no/photo.jpg")
        addPerson("https://5.googleusercontent.com/-kNdgn2USofM/AAAAAAAAAAI/AAAAAAAAAPc/CqRWdM7i6mU/s160-c-k-no/photo.jpg")
        addPerson("https://5.googleusercontent.com/-RMhQHcPzrnw/AAAAAAAAAAI/AAAAAAAACLo/kAFanjRZUm8/s160-c-k-no/photo.jpg")
        addPerson("https://5.googleusercontent.com/-jZRoUqkmtoE/AAAAAAAAAAI/AAAAAAAAAAA/UT5KpGHK2c4/s160-c-k-no/photo.jpg")
        addPerson("https://6.googleusercontent.com/-0B9XPsvsO24/AAAAAAAAAAI/AAAAAAAAAro/ng_J0xJLZUw/s160-c-k-no/photo.jpg")
        */
    }

    func wasDragged(gesture: UIPanGestureRecognizer) {
        var label = gesture.view!

        let translation = gesture.translationInView(self.view)
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
        gesture.setTranslation(CGPointZero, inView: self.view)

        xFromCenter += translation.x
        println(xFromCenter)

        var rotation: CGAffineTransform = CGAffineTransformMakeRotation(xFromCenter / 200)
        var scaleAmount = min(50/abs(xFromCenter), 1)
        var scale: CGAffineTransform = CGAffineTransformScale(rotation, scaleAmount, scaleAmount)
        label.transform = scale

        if label.center.x < 100 {
            println("Not chosen")
        } else if label.center.x > self.view.bounds.width - 100 {
            println("Chosen")
        }

        if gesture.state == UIGestureRecognizerState.Ended {
            xFromCenter = 0
            label.center = CGPointMake(self.view.bounds.width/2, self.view.bounds.height/2)
            rotation = CGAffineTransformMakeRotation(0)
            scaleAmount = 1
            scale = CGAffineTransformScale(rotation, scaleAmount, scaleAmount)
            label.transform = scale
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
