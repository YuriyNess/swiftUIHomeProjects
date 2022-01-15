//
//  ContentView.swift
//  BootShop
//
//  Created by YuriyFpc on 02.12.2021.
//

import SwiftUI

struct ContentView: View {

    @State var selectedBootName = "boot2"
    @State var bottsArray = ["boot1","boot2","boot3","boot4","boot5","boot6","boot7","boot8"]
    
    var firstBootAfterSelected: String? {
        guard let index = bottsArray.firstIndex(of: selectedBootName) else { return nil }
        return bottsArray.safeObjectAt(index: index + 1)
    }
    
    var secondBootAfterSelected: String? {
        guard let boot = firstBootAfterSelected, let index = bottsArray.firstIndex(of: boot) else { return nil }
        return bottsArray.safeObjectAt(index: index + 1)
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center, spacing: 0) {
                Image("nike")
                HStack(spacing: 30) {
                    VStack(spacing: 0) {
                        Text("Hot")
                            .foregroundColor(.orange)
                            .bold()
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.orange)
                            .frame(width: 30, height: 4, alignment: .center)
                    }
                    Text("Selling")
                        .foregroundColor(.gray)
                        .bold()
                    Text("Presale")
                        .foregroundColor(.gray)
                        .bold()
                }
                .padding(.all, 20)
                ZStack {
                    Image(secondBootAfterSelected ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width / 1.5, height:  proxy.size.height / 2.4, alignment: .center)
                        .clipped()
                        .cornerRadius(24)
                        .shadow(color: .gray, radius: 4, x: 0, y: 0)
                        .rotationEffect(Angle(degrees: -8))
                        .offset(x: -20, y: -4)
                    Image(firstBootAfterSelected ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width / 1.5, height:  proxy.size.height / 2.4, alignment: .center)
                        .clipped()
                        .cornerRadius(24)
                        .shadow(color: .gray, radius: 4, x: 0, y: 0)
                        .rotationEffect(Angle(degrees: 8))
                        .offset(x: 20, y: -4)

                    Image(selectedBootName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width / 1.5, height:  proxy.size.height / 2.4, alignment: .center)
                        .clipped()
                        .cornerRadius(24)
                        .shadow(color: .gray, radius: 4, x: 0, y: 0)
                }
                .padding(.all, 24)
                Button(action: {}, label: {
                    Text("Buy now")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth:.infinity)
                })
                .frame(width: proxy.size.width / 2.4, height: 40)
                .background(Color.orange)
                .cornerRadius(20)
                .shadow(color: .orange, radius: 10, x: 0.0, y: 6.0)
                .padding(.top, 20)
                HStack {
                    Text("Favorites")
                        .bold()
                    Spacer()
                }
                .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16))

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(bottsArray, id: \.self) { bootName in
                            if selectedBootName == bootName {
                                Image(bootName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .cornerRadius(25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.orange, lineWidth: 4)
                                    )
                            } else {
                                Image(bootName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .cornerRadius(25)
                                    .onTapGesture {
                                        selectedBootName = bootName
                                    }
                            }
                        }
                    }
                    .padding()
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .background(Color.lightGray0)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
