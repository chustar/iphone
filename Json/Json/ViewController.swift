//
//  ViewController.swift
//  Json
//
//  Created by Chuma Nnaji on 1/4/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let url: NSURL = NSURL(string: "http://www.telize.com/geoip")!
        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithURL(url, completionHandler: {
            data, response, error -> Void in
            if error != nil {
                println(error)
            } else {
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                println(jsonResult["country_code"])
            }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

