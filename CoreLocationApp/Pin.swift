//
//  pin.swift
//  CoreLocationApp
//
//  Created by Song on 1/18/18.
//  Copyright © 2018 Song. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
//    let title: String?
//    let locationName: String
//    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
//        self.title = title
//        self.locationName = locationName
//        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
//    var subtitle: String? {
//        return locationName
//    }
}
