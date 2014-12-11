//
//  ViewController.swift
//  Stopwatch
//
//  Created by Chuma Nnaji on 12/8/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer: NSTimer? = nil
    var count: Int = 0

    @IBOutlet weak var time: UILabel!

    @IBAction func play(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
    }

    @IBAction func pause(sender: AnyObject) {
        timer?.invalidate()
        timer = nil
    }

    @IBAction func reset(sender: AnyObject) {
        pause(sender)
        count = 0
        time.text = "0"
    }

    func result() {
        count++
        time.text = "\(count)"
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

