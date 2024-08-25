//
//  indobytesUserBrowserTests.swift
//  indobytesUserBrowserTests
//
//  Created by Samuel Napitupulu on 25/08/24.
//

import XCTest
@testable import indobytesUserBrowser

final class indobytesUserBrowserTests: XCTestCase {
    
    func testFetchUsersSuccess() {
        // Setup mocks
        let mockApiService = MockAPIService()
        let mockUsers = [
            User(id: 1, name: "John Doe", username: "johndoe", email: "johndoe@example.com", address: Address(street: "123 Main St", suite: "Apt 1", city: "Metropolis", zipcode: "12345"), phone: "123-456-7890", website: "https://johndoe.com", company: Company(name: "Company name", catchPhrase: "Here catchphrase", bs: "Here more for you")),
            User(id: 2, name: "Jane Smith", username: "janesmith", email: "janesmith@example.com", address: Address(street: "456 Elm St", suite: "Apt 2", city: "Gotham", zipcode: "54321"), phone: "987-654-3210", website: "https://janesmith.com", company: Company(name: "Company name", catchPhrase: "Here catchphrase", bs: "Here more for you"))
        ]
        mockApiService.mockFetchUsersResponse = .success(mockUsers)
        
        let viewModel = UserListViewModel(apiService: mockApiService)
        
        viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.users.count, 0)
        
        
        let expectation = XCTestExpectation(description: "Waiting for fetch completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.users.count, 2)
        XCTAssertEqual(viewModel.filteredUsers.count, 2)
        XCTAssertNil(viewModel.error)
    }
    
    func testSearchUsersByEmptyQuery() {
        let viewModel = UserListViewModel()
        viewModel.users = [
            User(id: 1, name: "John Doe", username: "johndoe", email: "johndoe@example.com", address: Address(street: "123 Main St", suite: "Apt 1", city: "Metropolis", zipcode: "12345"), phone: "123-456-7890", website: "https://johndoe.com", company: Company(name: "Company name", catchPhrase: "Here catchphrase", bs: "Here more for you")),
            User(id: 2, name: "Jane Smith", username: "janesmith", email: "janesmith@example.com", address: Address(street: "456 Elm St", suite: "Apt 2", city: "Gotham", zipcode: "54321"), phone: "987-654-3210", website: "https://janesmith.com", company: Company(name: "Company name", catchPhrase: "Here catchphrase", bs: "Here more for you"))
        ]
        
        viewModel.filterUsers(by: "")
        
        XCTAssertEqual(viewModel.filteredUsers.count, 2)
        XCTAssertEqual(viewModel.filteredUsers.first?.name, "John Doe")
    }
    
    func testSearchUsers() {
        let viewModel = UserListViewModel()
        viewModel.users = [
            User(id: 1, name: "John Doe", username: "johndoe", email: "johndoe@example.com", address: Address(street: "123 Main St", suite: "Apt 1", city: "Metropolis", zipcode: "12345"), phone: "123-456-7890", website: "https://johndoe.com", company: Company(name: "Company name", catchPhrase: "Here catchphrase", bs: "Here more for you")),
            User(id: 2, name: "Jane Smith", username: "janesmith", email: "janesmith@example.com", address: Address(street: "456 Elm St", suite: "Apt 2", city: "Gotham", zipcode: "54321"), phone: "987-654-3210", website: "https://janesmith.com", company: Company(name: "Company name", catchPhrase: "Here catchphrase", bs: "Here more for you"))
        ]
        
        viewModel.filterUsers(by: "john")
        
        XCTAssertEqual(viewModel.filteredUsers.count, 1)
        XCTAssertEqual(viewModel.filteredUsers.first?.name, "John Doe")
    }
    
    func testNoInternetError() {
        // Setup mocks
        let mockApiService = MockAPIService()
        let mockError = APIErrorState.noInternet
        
        mockApiService.mockFetchUsersResponse = .failure(mockError)
        
        // Create ViewModel with mock
        let viewModel = UserListViewModel(apiService: mockApiService)
        
        viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.users.count, 0)
        
        let expectation = XCTestExpectation(description: "Waiting for fetch completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertEqual(viewModel.filteredUsers.count, 0)
        XCTAssertEqual(viewModel.error?.errorDescription, mockError.errorDescription)
    }
    
    func testInvalidURLError() {
        // Setup mocks
        let mockApiService = MockAPIService()
        let mockError = APIErrorState.invalidURL
        
        mockApiService.mockFetchUsersResponse = .failure(mockError)
        
        // Create ViewModel with mock
        let viewModel = UserListViewModel(apiService: mockApiService)
        
        viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.users.count, 0)
        
        let expectation = XCTestExpectation(description: "Waiting for fetch completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertEqual(viewModel.filteredUsers.count, 0)
        XCTAssertEqual(viewModel.error?.errorDescription, mockError.errorDescription)
    }
    
    func testEmptyResponseData() {
        // Setup mocks
        let mockApiService = MockAPIService()
        let mockError = APIErrorState.dataEmpty

        mockApiService.mockFetchUsersResponse = .failure(mockError)
        
        // Create ViewModel with mock
        let viewModel = UserListViewModel(apiService: mockApiService)
        
        viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.users.count, 0)
        
        let expectation = XCTestExpectation(description: "Waiting for fetch completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertEqual(viewModel.filteredUsers.count, 0)
        XCTAssertEqual(viewModel.error?.errorDescription, mockError.errorDescription)
    }
}
