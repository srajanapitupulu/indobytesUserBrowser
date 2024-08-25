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
            ZStack(alignment: .center) {
                VStack(alignment: .center) {
                    Text("Profile")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
                        .shadow(color: Color(hex: "#F7D6B4"), radius: 0, x: 2, y: 3)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(EdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10))
            
            Divider()
                .padding(0)
                .background(Color.black)
            
            Spacer()
            
            // Use KFImage from Kingfisher to load the image
            ZStack {
                Circle()
                    .frame(width: 250, height: 250)
                    .shadow(color: Color(hex: "#F7D6B4"), radius: 0, x: 10, y: 15)
                
                KFImage(URL(string: "https://i.pravatar.cc/1000?u=\(user.id)"))
                    .placeholder {
                        Image(systemName: "person.crop.circle.fill")
                            .frame(width: 250, height: 250)
                    }
                    .cancelOnDisappear(true) // Cancel the image loading if the view disappears
                    .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
            }
            
            
            Spacer()
            
            Text(user.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            // User Details
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Username")
                        .font(.headline)
                        .frame(width: 100, alignment: .leading)
                    Text(user.username)
                        .font(.body)
                }
                
                HStack {
                    Text("Email")
                        .font(.headline)
                        .frame(width: 100, alignment: .leading)
                    Text(user.email)
                        .font(.body)
                }
                
                HStack(alignment: .top) {
                    Text("Address")
                        .font(.headline)
                        .frame(width: 100, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text(user.address.suite)
                            .font(.body)
                        Text(user.address.street)
                            .font(.body)
                        Text("\(user.address.city), \(user.address.zipcode)")
                            .font(.body)
                    }
                }
                
                HStack {
                    Text("Phone")
                        .font(.headline)
                        .frame(width: 100, alignment: .leading)
                    Text(user.phone)
                        .font(.body)
                }
                
                HStack {
                    Text("Website")
                        .font(.headline)
                        .frame(width: 100, alignment: .leading)
                    Text(user.website)
                        .font(.body)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .background(Color(hex: "#F9F5F2"))
        .navigationBarHidden(true) // Hide the default navigation bar
    }
}
