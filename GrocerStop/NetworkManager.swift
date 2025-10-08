//
//  NetworkManager.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import Foundation

enum NetworkError: Error {
    case invalidURL
    case fileNotFound
    case decodingError
    case unknownError(Error)
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // Asynchronously fetches products from the local JSON file.
    // This can be easily swapped for a real URLSession data task.
    func fetchProducts() async -> Result<[Product], NetworkError> {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            return .failure(.fileNotFound)
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            // Adding an artificial delay to simulate a real network call
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            
            let decoder = JSONDecoder()
            // Using UUIDs directly requires a specific decoding strategy if they aren't standard format
            // But since we use Codable on our model, this works for our new JSON.
            let products = try decoder.decode([Product].self, from: data)
            
            return .success(products)
        } catch let error as DecodingError {
            print("Decoding Error: \(error)")
            return .failure(.decodingError)
        } catch {
            print("An unknown error occurred: \(error)")
            return .failure(.unknownError(error))
        }
    }
}
