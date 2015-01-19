//
//  ViewController.swift
//  Back to Bach
//
//  Created by Chuma Nnaji on 1/3/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()

    @IBOutlet weak var volumeSlider: UISlider!

    @IBAction func play(sender: AnyObject) {
        player.play()
    }

    @IBAction func pause(sender: AnyObject) {
        player.pause()
    }

    @IBAction func stop(sender: AnyObject) {
        player.stop()
        player.currentTime = 0
    }

    @IBAction func changeVolume(sender: AnyObject) {
        player.volume = volumeSlider.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")!)
        var error: NSError? = nil
        player = AVAudioPlayer(contentsOfURL: url, error: &error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

