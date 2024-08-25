//
//  APIService.swift
//  indobytesUserBrowser
//
//  Created by bm yanti on 25/08/24.
//
import Foundation

protocol APIServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class APIService: APIServiceProtocol {
    private let urlString = "https://jsonplaceholder.typicode.com/users"
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
}
