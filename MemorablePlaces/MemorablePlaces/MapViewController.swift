//
//  MapViewController.swift
//  MemorablePlaces
//
//  Created by Chuma Nnaji on 12/26/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var currentLocation: CLLocation? = nil
class MapViewController: ViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var manager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Core Location
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

        // Long Press Recognizer
        var recognizer: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "action:")
        recognizer.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(recognizer)
    }

    func action(recognizer: UIGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
            var touchPoint = recognizer.locationInView(self.mapView)
            var newCoordinate: CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)

            var annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            annotation.title = "\(annotation.coordinate)"

            mapView.addAnnotation(annotation)

            places.append(CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude))
//            NSUserDefaults.standardUserDefaults().setObject(places, forKey: "places")
//            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]) {
        if currentLocation == nil {
            var userLocation: CLLocation = locations[0] as CLLocation
            var span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            var region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation.coordinate, span)
            mapView.setRegion(region, animated: true)
        } else {
            var span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            if let coordinate = currentLocation?.coordinate {
                var region: MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
                mapView.setRegion(region, animated: true)
            }
        }
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error: \(error)")
    }

}
