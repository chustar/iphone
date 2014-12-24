//
//  ViewController.swift
//  Web Content
//
//  Created by Chuma Nnaji on 12/18/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var url = NSURL(string: "http://www.stackoverflow.com")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, {
            (data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

