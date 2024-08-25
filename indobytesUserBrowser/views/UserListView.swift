//
//  UserListView.swift
//  indobytesUserBrowser
//
//  Created by Samuel Napitupulu on 25/08/24.
//

import SwiftUI

let defaultBorderWidth: CGFloat = 0.5

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel
    
    @State private var searchText: String = ""
    
    var filteredUserList: [User] {
        if searchText.isEmpty {
            return viewModel.users
        }
        else {
            return viewModel.users.filter{ user in
                user.name.lowercased().contains(searchText.lowercased()) ||
                user.username.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {

                if case .noInternet = error {
                    VStack {
                        Image(systemName: "wifi.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        
                        Text(error.localizedDescription)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(Color.red)
                }
                else {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        
                        Text(error.localizedDescription)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(Color.red)
                }
                
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    TextField("Search users...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: defaultBorderWidth)
                        )
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    
                    Text(searchText.isEmpty ? "ALL USERS" : "SEARCH RESULT")
                        .background(Color.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .border(Color.gray, width: defaultBorderWidth)
                    
                    if filteredUserList.isEmpty {
                        VStack {
                            //exclamationmark.triangle
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            Text("No users found")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .foregroundColor(Color.gray.opacity(0.7))
                    }
                    else {
                        List(filteredUserList) { user in
                            UserCardView(user: user)
                                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                                .listRowSeparator(.hidden)
                        }
                        .listStyle(PlainListStyle())
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        .background(Color(hex: "#F9F5F2"))
                        .scrollIndicators(.hidden)
                    }
                }
                .background(Color(hex: "#F9F5F2"))
                .navigationTitle("Users")
                .onAppear {
                    viewModel.fetchUsers()
                }
            }
        }
    }
}

struct UserCardView: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            AsyncImage(url: URL(string: "https://i.pravatar.cc/150")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .frame(width: 40, height: 40)
            }
            .frame(width: 40, height: 40)
            .overlay(
                Circle()
                    .stroke(Color.yellow, lineWidth: 1)
            )
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 0) {
                Text(user.name)
                    .font(.headline)
                Text("@\(user.username)")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
    }
}
