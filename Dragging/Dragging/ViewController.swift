//
//  ViewController.swift
//  Dragging
//
//  Created by Chuma Nnaji on 2/9/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var xFromCenter: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var label: UILabel = UILabel(frame: CGRectMake(self.view.bounds.width/2 - 100, self.view.bounds.height/2 - 50, 200, 100))
        label.text = "DRAG ME"
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)

        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        label.addGestureRecognizer(gesture)

        label.userInteractionEnabled = true
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


}

