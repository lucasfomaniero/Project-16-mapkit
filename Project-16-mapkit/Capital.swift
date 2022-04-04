//
//  Capital.swift
//  Project-16-mapkit
//
//  Created by Lucas Maniero on 27/03/22.
//

import MapKit

class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
     init(title: String, coordinate: CLLocationCoordinate2D, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
