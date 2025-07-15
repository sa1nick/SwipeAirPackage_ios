//
//  APIService.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

import Foundation

final class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func postRequest<T: Codable, U: Codable>(
        endpoint: String,
        body: T,
        completion: @escaping (Result<U, Error>) -> Void
    ) {
        guard let url = URL(string: APIConstants.devBaseURL + endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -2)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(U.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
