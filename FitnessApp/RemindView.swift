//
//  RemindView.swift
//  FitnessApp
//
//  Created by YuriyFpc on 05.01.2022.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        VStack {
            Spacer()
            //DropdownView(headerTitle: "Notification time", title: "8:30 am")
            Spacer()
            Button(action: {}, label: {
                Text("Create")
                    .font(.system(size: 24, weight: .semibold))
            })
            .padding()
            Button(action: {}, label: {
                Text("Skip Remind for now")
                    .font(.system(size: 24, weight: .semibold))
            })
            .padding()
        }
        .padding()
        .foregroundColor(.primary)
        .navigationTitle("Remind")
    }
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        RemindView().preferredColorScheme(.dark).previewDevice(.some("iPhone 8"))
        RemindView().preferredColorScheme(.light).previewDevice(.some("iPhone 10"))
        RemindView().previewDevice(.some("iPhone 12 Pro Max"))
    }
}
