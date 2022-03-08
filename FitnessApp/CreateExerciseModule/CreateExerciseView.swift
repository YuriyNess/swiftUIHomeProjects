//
//  CreateView.swift
//  FitnessApp
//
//  Created by YuriyFpc on 03.01.2022.
//

import SwiftUI

struct CreateExerciseView: View {
        
    @StateObject var viewModel: CreateExerciseViewModel
    
    var dropDownsList: some View {
        ForEach(viewModel.dropDownOptions.indices) { index in
            DropdownView(model: $viewModel.dropDownOptions[index])
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                dropDownsList
                Spacer()
                Button(action: {
                    viewModel.addChallenge()
                }, label: {
                    Text("Create")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.primary)
                })
                .padding()            }
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil), content: {
            Alert(title: Text("Error!"),
                  message: Text(viewModel.error?.localizedDescription ?? ""),
                  dismissButton: Alert.Button.default(Text("OK"), action: {
                    viewModel.error = nil
                })
            )
        })
        .padding()
        .navigationTitle("Create")
        .navigationBarBackButtonHidden(true)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateExerciseView(viewModel: CreateExerciseViewModel()).preferredColorScheme(.dark).previewDevice(.some("iPhone 8"))
        }
        NavigationView {
            CreateExerciseView(viewModel: CreateExerciseViewModel()).preferredColorScheme(.light).previewDevice(.some("iPhone 10"))
        }
        NavigationView {
            CreateExerciseView(viewModel: CreateExerciseViewModel()).previewDevice(.some("iPhone 12 Pro Max"))
        }
    }
}
