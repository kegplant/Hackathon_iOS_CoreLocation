//
//  LocationViewController.swift
//  CoreLocationApp
//
//  Created by Song on 1/18/18.
//  Copyright © 2018 Song. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController:UIViewController, MKMapViewDelegate{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var labelText: UILabel!
    let locationManager = CLLocationManager()

    let regionRadius: CLLocationDistance = 1000
    var lastLocation:CLLocation?
    var firstTime=true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate =  self;
        self.mapView.showsUserLocation = true;
        labelText.text="it works!"
        enableBasicLocationServices()
//        if let initialLocation = lastLocation {
//            centerMapOnLocation(location: initialLocation)
//        }
        
        // show artwork on map

        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let pin = Pin(coordinate: (lastLocation?.coordinate)!)
        mapView.addAnnotation(pin)
    }
    

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}





extension LocationViewController: CLLocationManagerDelegate{
    func enableBasicLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            enableMyWhenInUseFeatures()
            break
        }
    }
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse:
            enableMyWhenInUseFeatures()
            break
            
        case .notDetermined, .authorizedAlways:
            break
        }
    }
    func disableMyLocationBasedFeatures(){
        print("disableMyLocationBasedFeatures")
    }
    func enableMyWhenInUseFeatures(){
        print("enableMyWhenInUseFeaatures")
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0  // In meters.
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last!
        if firstTime {
            firstTime=false
            let initialLocation = lastLocation!
            centerMapOnLocation(location: initialLocation)
        }
        //
        //            CLLocation(latitude: 21.282778, longitude: -157.829444)
        //
        print(lastLocation)
        
        // Do something with the location.
    }
}
