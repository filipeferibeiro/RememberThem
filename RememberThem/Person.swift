//
//  Person.swift
//  RememberThem
//
//  Created by Filipe Fernandes on 28/07/25.
//

import Foundation
import SwiftUI

struct Person: Codable, Identifiable, Comparable, Hashable {
    var id = UUID()
    var name: String
    var photo: Data
    
    var personImage: Image? {
        guard let inputImage = UIImage(data: photo) else { return nil }
        
        return Image(uiImage: inputImage)
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
