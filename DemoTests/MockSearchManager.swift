//
//  MockSearchManager.swift
//  Demo
//
//  Created by Seher Aytekin on 12/28/23.
//

import Foundation

final class MockSearchManager: SearchProtocol {
    func searchRentals(for keyword: String) async throws -> [Rental] {
        return []
    }
    
    enum Status {
        case success
        case failure
    }
    
    var status: Status
    
    init(_ status: Status) {
        self.status = status
    }
    
    private var rentals = [Rental(id: "1", attributes: Attributes(name: "Rent1", imageUrl: "http://image1")),
                   Rental(id: "2", attributes: Attributes(name: "Rent2", imageUrl: "http://image2")),
                   Rental(id: "3", attributes: Attributes(name: "Rent3", imageUrl: "http://image3")),
                   Rental(id: "4", attributes: Attributes(name: "Rent4", imageUrl: "http://image4")),
                   Rental(id: "5", attributes: Attributes(name: "Rent5", imageUrl: "http://image5"))]
    
    func search(with keyword: String, completion: @escaping (SearchResult<[Rental]>) -> Void) {
        if status == .success {
            completion(.success(rentals))
        } else {
            completion(.failure(.invalidURL))
        }
        
    }
    
    
}
