//
//  PersonDetailView.swift
//  RememberThem
//
//  Created by Filipe Fernandes on 28/07/25.
//

import SwiftUI

struct PersonDetailView: View {
    var person: Person
    
    var body: some View {
        ScrollView {
            person.personImage?
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle(person.name)
            
        
    }
}

#Preview {
    if let image = UIImage(named: "example")?.pngData() {
        PersonDetailView(person: Person(name: "Example", photo: image))
    } else {
        Text("Image not found")
    }
}
