//
//  Rental.swift
//  Demo
//
//  Created by Seher Aytekin on 12/28/23.
//

import Foundation

struct DataModel: Decodable {
    let rentals: [Rental]
    
    enum CodingKeys: String, CodingKey {
        case rentals = "data"
    }
}

struct Rental: Decodable {
    let id: String
    let attributes: Attributes
}

struct Attributes: Decodable {
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "primary_image_url"
        case name = "name"
    }
}
