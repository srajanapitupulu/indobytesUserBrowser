//
//  APIService.swift
//  indobytesUserBrowser
//
//  Created by Samuel Napitupulu on 25/08/24.
//
import Foundation

enum APIErrorState: Error, LocalizedError {
    case invalidURL
    case dataEmpty
    case serverError(Error, statusCode: Int)
    case noInternet
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .dataEmpty:
            return "No data response from the server."
        case .serverError(let error, let statusCode):
            return "Server error [code: \(statusCode)]: \(error.localizedDescription)"
        case .noInternet:
            return "You appears to be offline. Please check your internet connection."
        case .decodingError(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        }
    }
}

protocol APIServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], APIErrorState>) -> Void)
}


class APIService: APIServiceProtocol {
    private let urlString = "https://jsonplaceholder.typicode.com/users"
    
    func fetchUsers(completion: @escaping (Result<[User], APIErrorState>) -> Void) {
        
        // Check if the URL is valid or not
        // return invalid URL error when fail
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                if (error as NSError).code == -1009 {
                    // check for No Internet connection error code
                    // return no internet error when fail
                    completion(.failure(.noInternet))
                } else {
                    // return localized description for general error
                    completion(.failure(.decodingError(error)))
                }
                return
            }
            
            // Check if server return HTTP STATUS CODE other than 200
            // return status code and error description message when fail
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.dataEmpty))
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(error!, statusCode: httpResponse.statusCode)))
                return
            }
            
            // Check for data response if its empty or not
            // return Error Data Empty when response is empty
            guard let data = data else {
                completion(.failure(.dataEmpty))
                return
            }
            
            do {
                // return user data list from server
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch let decodingError {
                // return error description message when fail
                completion(.failure(.decodingError(decodingError)))
            }
        }.resume()
    }
}
