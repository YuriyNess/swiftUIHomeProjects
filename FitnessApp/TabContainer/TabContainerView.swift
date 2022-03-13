//
//  TabContainer.swift
//  FitnessApp
//
//  Created by YuriyFpc on 13.03.2022.
//

import SwiftUI

struct TabContainerView: View {
    
    @StateObject private var viewModel = TabContainerViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(viewModel.tabs, id: \.self) { model in
                Text(model.title)
                    .tabItem {
                        Image(systemName: model.imageName)
                        Text(model.title)
                    }.tag(model.type)
            }
        }.accentColor(.primary)
    }
    
    @ViewBuilder
    func tabView(for tabItemType: TabItemModel.TabItemType) -> some View {
        switch tabItemType {
        case .challengeList:
            Text("challengeList")
        case .settings:
            Text("settings")
        case .log:
            Text("log")
        }
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView().preferredColorScheme(.dark).previewDevice(.some("iPhone 8"))
        TabContainerView().preferredColorScheme(.light).previewDevice(.some("iPhone 10"))
        TabContainerView().previewDevice(.some("iPhone 12 Pro Max"))
    }
}
