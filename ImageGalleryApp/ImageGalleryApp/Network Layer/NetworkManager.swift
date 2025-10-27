//
//  NetworkManager.swift
//  ImageGalleryApp
//
//  Created by Himanshu's MacBook on 28/10/25.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func request<T: Decodable>(
        url: String,
        method: String,
        headers: [String: String]? = nil,
        body: Data? = nil
    ) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method

        // Add custom headers if provided
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Set request body for POST/PUT
        if let body = body {
            request.httpBody = body
        }

        // Perform request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Validate response
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        // Decode JSON
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

