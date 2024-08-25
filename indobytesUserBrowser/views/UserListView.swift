//
//  UserListView.swift
//  indobytesUserBrowser
//
//  Created by Samuel Napitupulu on 25/08/24.
//

import SwiftUI

let defaultBorderWidth: CGFloat = 1

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    @State private var searchText: String = ""
    @State private var searchQuery: String = ""
    @State private var selectedUser: User? = nil
    @State private var isDetailViewPresented = false
    
//    private func filteredUserList() -> [User] {
//        if searchText.isEmpty {
//            return viewModel.users
//        }
//        else {
//            return viewModel.users.filter{ user in
//                user.name.lowercased().contains(searchText.lowercased()) ||
//                user.username.lowercased().contains(searchText.lowercased())
//            }
//        }
//    }
    
    private func performSearch() {
        searchQuery = searchText
        viewModel.filterUsers(by: searchQuery)
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
                    HStack {
                        TextField("Search users...", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(10)
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 10))
                            .shadow(color: Color(hex: "#F7D6B4"), radius: 0, x: 2, y: 3)
                            .controlSize(.large)
                        
                        Button(action: {
                            performSearch()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .fontWeight(.light)
                                .frame(width: 35, height: 35)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                .shadow(color: Color(hex: "#F7D6B4"), radius: 0, x: 2, y: 3)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                    
                    Spacer()
                    
                    Text(searchText.isEmpty ? "ALL USERS" : "SEARCH RESULT")
                        .background(Color.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .border(Color.black, width: 0.5)
                    
                    Spacer()
                    
                    if viewModel.filteredUsers.isEmpty {
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
                        List(viewModel.filteredUsers) { user in
                            UserCardView(user: user)
                                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    self.selectedUser = user
                                    self.isDetailViewPresented = true
                                }
                        }
                        .listStyle(PlainListStyle())
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        .background(Color(hex: "#F9F5F2"))
                        .scrollIndicators(.hidden)
                    }
                }
                .background(Color(hex: "#F9F5F2"))
                .navigationTitle("Users")
                .sheet(item: self.$selectedUser) { user in
                    UserDetailView(user: user)
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}
