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
import CoreData

class LocationViewController:UIViewController, MKMapViewDelegate{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var labelText: UILabel!
    let locationManager = CLLocationManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let regionRadius: CLLocationDistance = 1000
    var lastLocation:CLLocation?
    var firstTime=false
    var accidentLocations:[AccidentLocation]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accidentLocations=fetch()
        if accidentLocations.count>0 {
            let accidentLocation=CLLocation(latitude: accidentLocations[0].latitude, longitude: accidentLocations[0].longitude)
            print("centering map")
            centerMapOnLocation(location: accidentLocation)
            print("dropping pin")
            let pin = Pin(coordinate: accidentLocation.coordinate)
            mapView.addAnnotation(pin)
        } else {
            centerMapOnLocation(location: CLLocation(latitude: 37.38543025, longitude: -121.90970962))
//            firstTime=True
        }
        self.mapView.delegate =  self;
        self.mapView.showsUserLocation = true;
        labelText.text="Your pin will be saved for your future reference."
        enableBasicLocationServices()
//        if let initialLocation = lastLocation {
//            centerMapOnLocation(location: initialLocation)
//        }
        // show artwork on map
    }
    func fetch()->[AccidentLocation]{
        let locationRequest:NSFetchRequest<AccidentLocation> = AccidentLocation.fetchRequest()
        do {
            let fetchedLocations = try context.fetch(locationRequest)
            return fetchedLocations
        }
        catch {
            print("fetch error: ")
            print(error)
            return []
        }
    }
    func locationSave(){
        do{
            try context.save()
        } catch{
            print("core data save error: ")
            print(error)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        print("button pressed")
        if let _ = lastLocation {
            print("lastLocation found, accidentlocations: \(accidentLocations.count)")
            let pin = Pin(coordinate: (lastLocation?.coordinate)!)
            mapView.addAnnotation(pin)
            if accidentLocations.count>0 {
                accidentLocations[0].latitude=(lastLocation?.coordinate.latitude)!
                accidentLocations[0].longitude=(lastLocation?.coordinate.longitude)!
            }else{
                let newLocation = AccidentLocation(context: context)
                newLocation.latitude=(lastLocation?.coordinate.latitude)!
                newLocation.longitude=(lastLocation?.coordinate.longitude)!
            }
            locationSave()
        }
    }
    
//    @IBAction func buttonPressed(_ sender: UIButton) {
//
//    }
    

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
