//
//  AddPersonView.swift
//  RememberThem
//
//  Created by Filipe Fernandes on 28/07/25.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var personName = ""
    @State private var pickerPhoto: PhotosPickerItem?
    @State private var selectedPhoto: Data?
    
    let locationFetcher = LocationFetcher()
    
    var displayPhoto: Image? {
        guard let selectedPhoto else { return nil }
        guard let inputImage = UIImage(data: selectedPhoto) else { return nil }
        
        return Image(uiImage: inputImage)
    }
    
    var savePerson: (Person) -> Void
    
    var hasAllInfo: Bool {
        !personName.isEmpty && selectedPhoto != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Person name") {
                    TextField("Name", text: $personName)
                }
                
                Section("Person image") {
                    PhotosPicker(selection: $pickerPhoto, matching: .images) {
                        if let displayPhoto {
                            displayPhoto
                                .resizable()
                                .clipShape(.rect(cornerRadius: 8))
                                .scaledToFit()
                                
                        } else {
                            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                        }
                    }
                    .onChange(of: pickerPhoto) {
                        Task {
                            selectedPhoto = try await pickerPhoto?.loadTransferable(type: Data.self)
                        }
                    }
                }
                
                Section {
                    Button("Save", action: save)
                }
                .disabled(!hasAllInfo)
            }
            .navigationTitle("Add new person")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                locationFetcher.start()
            }
        }
    }
    
    func save() {
        guard let selectedPhoto else { return }
        
        let latitude = locationFetcher.lastKnownLocation?.latitude
        let longitude = locationFetcher.lastKnownLocation?.longitude
        
        let newPerson = Person(name: personName, photo: selectedPhoto, latitude: latitude, longitude: longitude)
        
        savePerson(newPerson)
        dismiss()
    }
}

#Preview {
    AddPersonView { _ in }
}
