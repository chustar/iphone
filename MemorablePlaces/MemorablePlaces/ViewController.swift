//
//  ViewController.swift
//  MemorablePlaces
//
//  Created by Chuma Nnaji on 12/26/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit
import CoreLocation

var places: [CLLocation] = []

class ViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

//        places = NSUserDefaults.standardUserDefaults().arrayForKey("places") as [CLLocation]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var coordinate = places[indexPath.row].coordinate
        cell.textLabel?.text = "\(coordinate.latitude), \(coordinate.longitude)"

        return cell
    }
}

