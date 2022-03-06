//
//  DropdownView.swift
//  FitnessApp
//
//  Created by YuriyFpc on 03.01.2022.
//

import SwiftUI

struct DropdownView: View {
    
    var headerTitle: String {
        model.headerTitle
    }
    var title: String {
        model.title
    }
    
    @Binding var model: DropdownExerciseOptions
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select"),
                    buttons:
                        model.options.map({ option in
                            return ActionSheet.Button.default(Text(option.formattedValue)) {
                                self.model.selectedOption = option
                            }
                        })
        )
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }
            Button(action: {
                self.model.isSelected = true
            }, label: {
                HStack {
                    Text(title)
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                }
                .font(.system(size: 22, weight: .semibold))
            })
            .buttonStyle(PrimaryButtonStyle())
        }
        .actionSheet(isPresented: $model.isSelected, content: {
            actionSheet
        })
    }
}

//struct DropdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DropdownView(headerTitle: "Exercise", title: "Button").preferredColorScheme(.dark).previewDevice(.some("iPhone 8"))
//        }
//        DropdownView(headerTitle: "Exercise", title: "Button").preferredColorScheme(.light).previewDevice(.some("iPhone 10"))
//        DropdownView(headerTitle: "Exercise", title: "Button").previewDevice(.some("iPhone 12 Pro Max"))
//    }
//}
