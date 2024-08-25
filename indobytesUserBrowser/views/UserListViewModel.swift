//
//  UserListViewModel.swift
//  indobytesUserBrowser
//
//  Created by Samuel Napitupulu on 25/08/24.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var error: APIErrorState?
    
    private let apiService: APIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchUsers() {
        isLoading = true
        apiService.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let users):
                    self?.users = users
                    self?.error = nil // Clear any previous errors
                case .failure(let apiError):
                    self?.handleError(apiError)
                }
            }
        }
    }
    
    func retryFetchingUsers() {
        // Clear the previous error
        self.error = nil
        // Retry fetching users
        fetchUsers()
    }
    
    private func handleError(_ error: APIErrorState) {
        // Handle specific errors based on the APIError type
        switch error {
        case .invalidURL:
            // Handle URL errors (if applicable)
            self.error = .invalidURL
        case .dataEmpty:
            // Handle the case where no data is received
            self.error = .dataEmpty
        case .decodingError(let decodingError):
            // Handle JSON decoding errors
            self.error = .decodingError(decodingError)
        case .serverError(let errorData, let statusCode):
            // Handle server errors based on status code
            self.error = .serverError(errorData, statusCode: statusCode)
        case .noInternet:
            // Handle no internet connection
            self.error = .noInternet
        }
    }
}
