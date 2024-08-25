//
//  UserListView.swift
//  indobytesUserBrowser
//
//  Created by bm yanti on 25/08/24.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            } else {
                List(viewModel.users) { user in
                    UserCardView(user: user)
                }
                .navigationTitle("Users")
            }
        }
    }
}

struct UserCardView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(user.name)
                .font(.headline)
            Text(user.email)
                .font(.subheadline)
            Text(user.phone)
                .font(.subheadline)
            Text(user.website)
                .font(.subheadline)
            Divider()
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
