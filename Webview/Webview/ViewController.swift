//
//  ViewController.swift
//  Webview
//
//  Created by Chuma Nnaji on 1/4/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
                webView.delegate = self

        var html = "<html><head></head><body><h1>hello world</h1></body>"
//        var url = NSURL(string: "http://www.google.com")
//        var request = NSURLRequest(URL: url!)
//        webView.loadRequest(request)
        webView.loadHTMLString(html, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        println(error)
    }
}

