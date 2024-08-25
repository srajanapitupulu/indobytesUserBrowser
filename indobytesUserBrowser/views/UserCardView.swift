//
//  UserCardView.swift
//  indobytesUserBrowser
//
//  Created by Samuel Napitupulu on 25/08/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct UserCardView: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
//            AsyncImage(url: URL(string: "https://i.pravatar.cc/150")) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//            } placeholder: {
//                Image(systemName: "person.crop.circle.fill")
//                    .frame(width: 40, height: 40)
//            }
//            .frame(width: 40, height: 40)
//            .overlay(
//                Circle()
//                    .stroke(Color.yellow, lineWidth: 1)
//            )
//            .clipShape(Circle())
            
            // Use KFImage from Kingfisher to load the image
            KFImage(URL(string: "https://i.pravatar.cc/150?u=\(user.id)"))
                .placeholder {
                    Image(systemName: "person.crop.circle.fill")
                        .frame(width: 40, height: 40)
                }
                .cancelOnDisappear(true) // Cancel the image loading if the view disappears
                .resizable() // Make the image resizable
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                .shadow(radius: 3)
            
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
