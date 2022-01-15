//
//  PrimaryButtonStyle.swift
//  FitnessApp
//
//  Created by YuriyFpc on 03.01.2022.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .foregroundColor(.primary)
            .background(
                RoundedRectangle(cornerRadius: 8)
                            .fill(Color.primaryButton)
            )
    }
}
