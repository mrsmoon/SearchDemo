//
//  SearchManager.swift
//  Demo
//
//  Created by Seher Aytekin on 12/28/23.
//

import Foundation

protocol SearchProtocol {
    func search(with keyword: String, completion: @escaping (SearchResult<[Rental]>) -> Void)
    func searchRentals(for keyword: String) async throws -> [Rental]
}

enum SearchError: Error {
    case invalidURL
    case invalidData
    case parsingError
}

enum SearchResult<Model> where Model: Decodable  {
    case success(Model)
    case failure(SearchError)
}

class SearchManager: SearchProtocol {
    
    func searchRentals(for keyword: String) async throws -> [Rental] {
        let urlString = "https://search.outdoorsy.co/rentals"
        let queryItems = [URLQueryItem(name: "filter[keywords]", value: keyword),
                          URLQueryItem(name: "page[limit]", value: "8"),
                          URLQueryItem(name: "page[offset]", value: "8"),
        ]
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        
        let url = urlComponents?.url
        let (data, _) = try await URLSession.shared.data(from: url!)
        let model = try JSONDecoder().decode(DataModel.self, from: data)
        return model.rentals
    }
    
    func search(with keyword: String, completion: @escaping (SearchResult<[Rental]>) -> Void) {
        let url = "https://search.outdoorsy.co/rentals"
        let queryItems = [URLQueryItem(name: "filter[keywords]", value: keyword),
                          URLQueryItem(name: "page[limit]", value: "8"),
                          URLQueryItem(name: "page[offset]", value: "8"),
        ]
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(dataModel.rentals))
            } catch (let error) {
                print("Parsing error: \(error)")
                completion(.failure(.invalidData))
                return
            }
            
        }.resume()
    }
    
}
