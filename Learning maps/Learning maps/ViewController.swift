//
//  ViewController.swift
//  Learning maps
//
//  Created by Chuma Nnaji on 12/24/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        var latitude: CLLocationDegrees = 40.748700
        var longitude: CLLocationDegrees = -73.985653
        var latDelta: CLLocationDegrees = 0.01
        var longDelta: CLLocationDegrees = 0.01
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)

        mapView.setRegion(region, animated: true)

        var annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "The Statue of Liberty"
        annotation.subtitle = "Not really..."

        mapView.addAnnotation(annotation)

        // The colon is needed to tell the compiler that there will be parameters provided by the recognizer.
        // If there weren't any params, then we wouldn't need the colon. Does wrapping it in Selector() change anything?
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
            annotation.title = "User Created Annotation"
            annotation.subtitle = "Some other stuff"

            mapView.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

