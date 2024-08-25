//
//  MockAPIService.swift
//  indobytesUserBrowserTests
//
//  Created by Samuel Napitupulu on 26/08/24.
//

import Foundation
import XCTest
@testable import indobytesUserBrowser

class MockAPIService: APIServiceProtocol {
  var mockFetchUsersResponse: Result<[User], APIErrorState>!

  func fetchUsers(completion: @escaping (Result<[User], APIErrorState>) -> Void) {
    completion(mockFetchUsersResponse)
  }
}
