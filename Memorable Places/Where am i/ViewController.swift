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

    @IBOutlet weak var mapView: MKMapView!


    @IBAction func findMe(sender: AnyObject) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        if activePlace == -1 {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            let lat = NSString(string: places[activePlace]["lat"]!).doubleValue
            let long = NSString(string: places[activePlace]["long"]!).doubleValue

            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            mapView.setRegion(region, animated: true)

            var annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = places[activePlace]["name"]
            mapView.addAnnotation(annotation)
        }

        var recognizer = UILongPressGestureRecognizer(target: self, action: "action:")
        recognizer.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(recognizer)
    }

    func action(recognizer: UIGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
            let touchPoint = recognizer.locationInView(mapView)
            let coordinate = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)

            let location: CLLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            if geocoder.geocoding == false {
                geocoder.reverseGeocodeLocation(location, completionHandler: {
                    (placemarks: [AnyObject]!, error: NSError!) in
                    let placemark = placemarks[0] as CLPlacemark
                    var subThoroughfare: String
                    var thoroughfare: String

                    if (placemark.subThoroughfare == nil) {
                        subThoroughfare = ""
                    } else {
                        subThoroughfare = placemark.subThoroughfare
                    }
                    if (placemark.thoroughfare == nil) {
                        thoroughfare = " "
                    } else {
                        thoroughfare = placemark.thoroughfare
                    }

                    var annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "\(subThoroughfare) \(thoroughfare)"
                    if annotation.title == " " {
                        annotation.title == "Added \(NSDate())"
                    }
                    self.mapView.addAnnotation(annotation)

                    places.append(["name": annotation.title, "lat": "\(coordinate.latitude)", "long": "\(coordinate.longitude)"])
                })
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backSegue" {
            self.navigationController!.navigationBarHidden = false
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation = locations[0] as CLLocation

        let lat = userLocation.coordinate.latitude
        let long = userLocation.coordinate.longitude

        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()

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

