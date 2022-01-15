//
//  ContentView.swift
//  RegisterView1
//
//  Created by YuriyFpc on 30.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @ObservedObject private var kGuardian = KeyboardGuardian(viewsCount: 1)

    var body: some View {
        ZStack {
            Image("nature")
                .resizable()
                .blur(radius: 10)
            VStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20)
                    .frame(width: 260, height: 380, alignment: .center)
                    .overlay(
                        VStack {
                            Circle()
                                .fill(Color.white)
                                .overlay(
                                    Image("rocket")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 28, height: 28, alignment: .center)
                                )
                                .frame(width: 48, height: 48, alignment: .center)
                                .offset(x: 0, y: -24.0)
                            Image("european-union")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .shadow(color: .black, radius: 4, x: 0.0, y: 0.0)
                                .frame(width: 100, height: 100, alignment: .center)
                            Text("European Union")
                                .font(.title)
                                .bold()
                            JumpingPlaceholderTextField(text: $email, placeHolderText: "Username or Email")
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            JumpingPlaceholderTextField(text: $password, placeHolderText: "Password", isSecure: true)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                            Button("REGISTER") {
                                
                            }
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width: 160, height: 34, alignment: .center)
                            .background(Color.gray)
                            .cornerRadius(8)
                            Spacer()
                        }
                    )
                    .compositingGroup()
                    .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                Button(action: {}, label: {
                    Text("FORGOT PASSWORD")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.top, 10)
                })
            }
            .background(GeometryGetter(rect: $kGuardian.rects[0]))
            .offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.3))
            .onAppear { self.kGuardian.addObserver() }
            .onDisappear { self.kGuardian.removeObserver() }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
