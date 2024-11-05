//
//  Model.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 04/11/24.
//

import Foundation



typealias Street = Profile.Street
// MARK: - Welcome
struct ResponseData: Codable {
    let results: [Profile]
}

// MARK: - Result
struct Profile: Codable {
    
    let gender: Gender
    let name: Name
    let location: Location
    let email, nat, phone, cell: String
    let dob, registered: Timestamp
    let picture: Picture
    
    struct ID: Codable {
        let name: String
        let value: String?
    }
    
    // MARK: - Dob
    struct Timestamp: Codable {
        let date: String
        let age: Int
    }
    
    enum Gender: String, Codable {
        case female, male
    }
    
    struct Location: Codable {
        let street: Street
        let city, state, country: String
    }
    
    // MARK: - Street
    struct Street: Codable {
        let number: Int
        let name: String
    }

    // MARK: - Name
    struct Name: Codable {
        let title, first, last: String
    }

    // MARK: - Picture
    struct Picture: Codable {
        let large, medium, thumbnail: String
    }
}

extension Profile {
    var displayName: String { "\(name.first) \(name.last), \(dob.age)" }
    
    var displayAddress: String { "\(location.street.displayName) \(location.city)" }
}

extension Street {
    var displayName: String { "\(number), \(name)" }
}
