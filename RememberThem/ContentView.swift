//
//  ContentView.swift
//  RememberThem
//
//  Created by Filipe Fernandes on 28/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.persons.sorted()) { person in
                    PersonCardListView(person: person)
                }
            }
            .navigationTitle("RememberThem")
            .navigationDestination(for: Person.self, destination: { person in
                PersonDetailView(person: person)
            })
            .toolbar {
                Button("Add person", systemImage: "plus") {
                    viewModel.isShowingAddPersonView = true
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddPersonView) {
                AddPersonView(savePerson: viewModel.addNewPerson)
            }
        }
    }
}

#Preview {
    ContentView()
}
