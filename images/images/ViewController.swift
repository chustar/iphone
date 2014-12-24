//
//  ViewController.swift
//  images
//
//  Created by Chuma Nnaji on 12/21/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = NSTimer()
    var currentFrame = 1
    @IBOutlet weak var alien: UIImageView!
    @IBAction func buttonPressed(sender: AnyObject) {
        currentFrame = currentFrame == 5 ? 1 : currentFrame + 1
        alien.image = UIImage(named: "frame\(currentFrame).png")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
    }

    func result() {
        currentFrame = currentFrame == 5 ? 1 : currentFrame + 1
        alien.image = UIImage(named: "frame\(currentFrame).png")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
    //    alien.center = CGPointMake(alien.center.x - 400, alien.center.y + 400)
    //    alien.alpha = 0
        alien.frame = CGRectMake(100, 20, 0, 0)
    }

    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1, animations: {
//            self.alien.center = CGPointMake(self.alien.center.x + 400, self.alien.center.y - 400)
//            self.alien.alpha = 1
            self.alien.frame = CGRectMake(100, 20, 100, 200)
        })
    }
}

