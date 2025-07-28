//
//  PersonCardListView.swift
//  RememberThem
//
//  Created by Filipe Fernandes on 28/07/25.
//

import SwiftUI

struct PersonCardListView: View {
    var person: Person

    var body: some View {
        NavigationLink(value: person) {
            HStack {
                if let image = person.personImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(.circle)
                        .frame(width: 65, height: 65)
                }
                
                Text(person.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    if let image = UIImage(named: "example")?.pngData() {
        PersonCardListView(person: Person(name: "Example", photo: image, latitude: 50.1, longitude: 43.2))
    } else {
        Text("Image not found")
    }
}
