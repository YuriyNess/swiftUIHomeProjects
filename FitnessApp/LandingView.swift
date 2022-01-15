//
//  LandingView.swift
//  FitnessApp
//
//  Created by YuriyFpc on 22.12.2021.
//

import SwiftUI

struct LandingView: View {
    
    @State var createViewLinkIsActive: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    Image("pullups")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(Color.black.opacity(0.4))
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                    VStack {
                        Spacer()
                            .frame(width: proxy.size.width, height: proxy.size.height * 0.25, alignment: .center)
                        Text("Increment")
                            .foregroundColor(.white)
                            .font(Font.system(size: 64, weight: .medium))
                        Spacer()
                        NavigationLink(destination: CreateExerciseView(viewModel: CreateExerciseViewModel()), isActive: $createViewLinkIsActive) {
                            Button(action: {
                                createViewLinkIsActive = true
                            }, label: {
                                HStack {
                                    Image(systemName: "plus.circle")
                                    Text("Creat challenge")
                                        .bold()
                                }
                                .font(Font.system(size: 24, weight: .semibold))
                            })
                            .buttonStyle(PrimaryButtonStyle())
                            .padding(.all, 32)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            }
            .ignoresSafeArea(.all)
        }
        .accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice(.some("iPhone 8"))
        LandingView().previewDevice(.some("iPhone 10"))
        LandingView().previewDevice(.some("iPhone 12 Pro Max"))
    }
}

