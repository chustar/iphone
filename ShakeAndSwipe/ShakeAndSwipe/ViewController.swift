//
//  ViewController.swift
//  ShakeAndSwipe
//
//  Created by Chuma Nnaji on 1/3/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()

    var files = ["enlarge", "laugh", "slip", "trombone", "yell"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake {
            var rand = Int(arc4random_uniform(UInt32(files.count)))
            var fileUrl = NSBundle.mainBundle().URLForResource(files[rand], withExtension: "wav")
            var error: NSError? = nil

            player = AVAudioPlayer(contentsOfURL: fileUrl, error: &error)
            player.play()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

