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
    
    var model: DropdownExerciseOptions
    
    var body: some View {
        VStack {
            HStack {
                Text(headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }
            Button(action: {}, label: {
                HStack {
                    Text(title)
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                }
                .font(.system(size: 22, weight: .semibold))
            })
            .buttonStyle(PrimaryButtonStyle())
        }
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
