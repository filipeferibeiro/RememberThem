//
//  Person.swift
//  RememberThem
//
//  Created by Filipe Fernandes on 28/07/25.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

struct Person: Codable, Identifiable, Comparable, Hashable {
    var id = UUID()
    var name: String
    var photo: Data
    var latitude: Double?
    var longitude: Double?
    
    var personImage: Image? {
        guard let inputImage = UIImage(data: photo) else { return nil }
        
        return Image(uiImage: inputImage)
    }
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var mapPosition: MKCoordinateRegion? {
        guard let coordinate else { return nil }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
