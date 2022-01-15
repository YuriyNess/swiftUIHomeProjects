//
//  JumpingPlaceholderTextField.swift
//  RegisterView1
//
//  Created by YuriyFpc on 01.12.2021.
//

import SwiftUI

struct JumpingPlaceholderTextField: View {
    
    @Binding var text: String
    @State var placeHolderText: String
    @State var isSecure: Bool = false
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .border(Color.lightGray, width: 1)
            .frame(height: 40, alignment: .center)
            .overlay(
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        if !text.isEmpty {
                            Text(placeHolderText)
                                .font(.caption2)
                                .foregroundColor(.lightGray2)
                        }
                        if isSecure {
                            SecureField(placeHolderText, text: $text)
                                .foregroundColor(.black)
                                .autocapitalization(.none)
                        } else {
                            TextField(placeHolderText, text: $text)
                                .autocapitalization(.none)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    Spacer()
                }
                .frame(height: 40, alignment: .leading)
            )
    }
}

struct JumpingPlaceholderTextField_Previews: PreviewProvider {
    static var previews: some View {
        JumpingPlaceholderTextField(text: .constant("2"), placeHolderText: "Username or Email", isSecure: false)
    }
}
