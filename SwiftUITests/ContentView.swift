//
//  ContentView.swift
//  SwiftUITests
//
//  Created by YuriyFpc on 30.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var title: String = "Hello, world!"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(title)
                        .padding()
                        .preference(key: TextPreferenceKey.self, value: "1")
                    Spacer()
                }
                .preference(key: TextPreferenceKey.self, value: "3")
                HStack {
                    Text(title)
                        .padding()
                        .preference(key: TextPreferenceKey.self, value: "1")
                    Spacer()
                }
                .preference(key: TextPreferenceKey.self, value: "2")
            }
            .preference(key: TextPreferenceKey.self, value: "4")
            .onPreferenceChange(TextPreferenceKey.self, perform: { value in
                debugPrint(value)
                self.title = value
            })
        }
//        .onPreferenceChange(TextPreferenceKey.self, perform: { value in
//            debugPrint(value)
//            self.title = value
//        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TextPreferenceKey: PreferenceKey {
    static var defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = value + nextValue() + "x"
    }
}

