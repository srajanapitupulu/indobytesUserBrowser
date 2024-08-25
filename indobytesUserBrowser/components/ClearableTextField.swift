//
//  ClearableTextField.swift
//  indobytesUserBrowser
//
//  Created by Samuel Napitupulu on 26/08/24.
//

import Foundation
import SwiftUI

struct ClearableTextField: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            TextField("", text: $text)
                .textFieldStyle(.roundedBorder)
                .cornerRadius(10)
//                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 10))
//                .shadow(color: Color(hex: "#F7D6B4"), radius: 0, x: 2, y: 3)
////                .controlSize(.large)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.black, lineWidth: 1)
//                )
                .onTapGesture {
                    isEditing = true
                }

            if isEditing && !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color(hex: "#F7D6B4"), radius: 0, x: 1, y: 2)
                        .padding(.trailing, 5)
                }
            }
        }
        .padding(.horizontal, 5)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color(hex: "#F7D6B4"), radius: 0, x: 2, y: 3)
    }
}
