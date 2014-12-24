//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Chuma Nnaji on 12/20/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!

    @IBOutlet weak var message: UILabel!

    @IBAction func buttonPressed(sender: AnyObject) {
        self.view.endEditing(true)
        var urlString = "http://www.weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        var url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            var urlContents = NSString(data: data, encoding: NSUTF8StringEncoding)!

            if urlContents.containsString("<span class=\"phrase\">") {
                var contentArray = urlContents.componentsSeparatedByString("<span class=\"phrase\">")
                var newContentArray = contentArray[1].componentsSeparatedByString("</span>")
                dispatch_async(dispatch_get_main_queue()) {
                    self.message.text = newContentArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.message.text = "Couldn't find that city. Please try again."
                }
            }
        }
        task.resume()
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

