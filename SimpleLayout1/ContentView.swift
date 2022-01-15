//
//  ContentView.swift
//  SimpleLayout1
//
//  Created by YuriyFpc on 30.11.2021.
//

import SwiftUI

struct GrayButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(Color.red)
            .background(Color.lightGray)
            .cornerRadius(16)
    }
}

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 30) {
                    Button("Edit channel") {
                        
                    }
                    .modifier(GrayButtonModifier())
                    Button("Edit content") {
                        
                    }
                    .modifier(GrayButtonModifier())
                }
                Rectangle()
                    .fill(Color.lightGray)
                    .frame(height: 1, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                HStack {
                    Image("apple")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100, alignment: .leading)
                        .padding()
                    VStack(alignment: .leading) {
                        Text("Title: Apples")
                            .font(.title)
                        Text("Description: eating big apples, and some other fruits.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                .frame(height: 120, alignment: .top)
                .clipped()
                Spacer()
            }
            .padding(.top, 20)
            .navigationTitle("Some title")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
