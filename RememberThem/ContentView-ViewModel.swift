//
//  ContentView-ViewModel.swift
//  RememberThem
//
//  Created by Filipe Fernandes on 28/07/25.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        let savePath = URL.documentsDirectory.appending(path: "SavedPersons")
        
        var persons: [Person] = []
        var isShowingAddPersonView: Bool = false
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                persons = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                print(error.localizedDescription)
                persons = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(persons)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addNewPerson(_ person: Person) {
            persons.append(person)
            save()
        }
    }
}
