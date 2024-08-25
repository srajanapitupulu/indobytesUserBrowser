//
//  UserDetailView.swift
//  indobytesUserBrowser
//
//  Created by Samuel Napitupulu on 25/08/24.
//

import SwiftUI
import Kingfisher

struct UserDetailView: View {
    let user: User
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // Top Bar with user's profile information
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Text("Profile")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
                Spacer()
                // Close button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .frame(width: 30, height: 30)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
                }
            }
            .padding()
            .background(Color.cyan)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Spacer()
            
            // User Details
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Image(systemName: "envelope.fill")
                    Text(user.email)
                }
                
                HStack {
                    Image(systemName: "phone.fill")
                    Text(user.phone)
                }
                
                HStack {
                    Image(systemName: "house.fill")
                    Text("\(user.address.suite), \(user.address.street), \(user.address.city)")
                }
                
                HStack {
                    Image(systemName: "globe")
                    Text(user.website)
                }
                
                HStack {
                    Image(systemName: "briefcase.fill")
                    Text(user.company.name)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.green)
            .cornerRadius(10)
            Spacer()
        }
        .navigationBarHidden(true) // Hide the default navigation bar
    }
}
