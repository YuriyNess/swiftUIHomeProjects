//
//  CreateView.swift
//  FitnessApp
//
//  Created by YuriyFpc on 03.01.2022.
//

import SwiftUI

struct CreateExerciseView: View {
    
    @State var remindViewLinkIsActive: Bool = false
    
    @StateObject var viewModel: CreateExerciseViewModel
    
    var dropDownsList: some View {
        ForEach(viewModel.dropDownOptions) { option in
            DropdownView(model: Binding(get: { option }, set: { option in
                debugPrint("Invoke SET 22222")
            }))
        }
//        ForEach(viewModel.dropDownOptions.indices, id: \.self) { index in
//            DropdownView(model: $viewModel.dropDownOptions[index])
//        }
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select"),
                    buttons:
                        viewModel.displayedOptions.indices.map({ index in
                            let option = viewModel.displayedOptions[index]
                            return ActionSheet.Button.default(Text(option.formattedValue)) {
                                viewModel.selectOptionInSelectedDropdown(optionIndex: index)
                            }
                        })
        )
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropDownsList
                Spacer()
                NavigationLink(
                    destination: RemindView(),
                    isActive: $remindViewLinkIsActive,
                    label: {
                        Button(action: {
                            remindViewLinkIsActive = true
                        }, label: {
                            Text("Next")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.primary)
                        })
                        .padding()
                    })
            }
            .actionSheet(isPresented: Binding<Bool>(get: {
                viewModel.hasSelectedDropDowns
            }, set: { _ in
                debugPrint("Invoke SET 11111")
                return
            }), content: {
                actionSheet
            })
            .padding()
            .navigationTitle("Create")
        }
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
