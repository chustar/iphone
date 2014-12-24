//
//  ViewController.swift
//  Where am i
//
//  Created by Chuma Nnaji on 12/24/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    var locationManager: CLLocationManager!
    var geocoder: CLGeocoder!

    override func viewDidLoad() {
        super.viewDidLoad()

        geocoder = CLGeocoder()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation = locations[0] as CLLocation
        println(userLocation)

        latLabel.text = userLocation.coordinate.latitude.description
        longLabel.text = userLocation.coordinate.longitude.description
        headingLabel.text = userLocation.course.description
        speedLabel.text = userLocation.speed.description

        if geocoder.geocoding == false {
            geocoder.reverseGeocodeLocation(userLocation, completionHandler: {
                (placemarks: [AnyObject]!, error: NSError!) in
                var placemark = placemarks[0] as CLPlacemark
                self.addressLabel.text = ABCreateStringWithAddressDictionary(placemark.addressDictionary, true)
            })
        }
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error: \(error)")
    }
}

