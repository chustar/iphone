//
//  ViewController.swift
//  StoringImages
//
//  Created by Chuma Nnaji on 1/4/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        let url = NSURL(string: "https://www.bing.com/az/hprichbg/rb/EvergladesTrees_EN-US13299681542_1920x1080.jpg")
//        let urlRequest = NSURLRequest(URL: url!)
//        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
//            response, data, error in
//            if error != nil {
//                println("There was an error")
//            } else {
//                let image = UIImage(data: data)
//                //                self.imageView.image = image
//                var documentsDirectory: String? = nil
//                var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
//                if paths.count > 0 {
//                    documentsDirectory = paths[0] as? String
//                    var savePath = documentsDirectory! + "/file.jpg"
//                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
//                    self.imageView.image = UIImage(named: savePath)
//                }
//            }
//        })

        var documentsDirectory: String? = nil
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        if paths.count > 0 {
            documentsDirectory = paths[0] as? String
            var savePath = documentsDirectory! + "/file.jpg"
            self.imageView.image = UIImage(named: savePath)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

