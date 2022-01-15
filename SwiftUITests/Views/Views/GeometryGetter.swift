//
//  GeometryGetter.swift
//  SwiftUITests
//
//  Created by YuriyFpc on 02.12.2021.
//

import SwiftUI

///Should be set as background or overlay to get and populate the view size
struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }
                
                return AnyView(Color.clear)
            }
        }
    }
}
