//
//  PersonDetailView.swift
//  RememberThem
//
//  Created by Filipe Fernandes on 28/07/25.
//

import SwiftUI
import MapKit

struct PersonDetailView: View {
    var person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            person.personImage?
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 10))
            
            if let mapPosition = person.mapPosition, let coordinate = person.coordinate {
                Text("Location")
                    .font(.title.bold())
                
                Map(initialPosition: MapCameraPosition.region(mapPosition)) {
                    Marker("Meet up", coordinate: coordinate)
                }
                .clipShape(.rect(cornerRadius: 10))
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(person.name)
    }
}

#Preview {
    if let image = UIImage(named: "example")?.pngData() {
        PersonDetailView(person: Person(name: "Example", photo: image, latitude: 50.3, longitude: -76.3))
    } else {
        Text("Image not found")
    }
}
