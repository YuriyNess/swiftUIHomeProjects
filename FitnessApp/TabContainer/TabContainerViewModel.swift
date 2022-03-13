//
//  TabContainerViewModel.swift
//  FitnessApp
//
//  Created by YuriyFpc on 13.03.2022.
//

import Combine

final class TabContainerViewModel: ObservableObject {
    @Published var selectedTab: TabItemModel.TabItemType = .challengeList
    
    let tabs: [TabItemModel] = [
        .init(imageName: "book", title: "Activity log", type: .log),
        .init(imageName: "list.bullet", title: "Challenges", type: .challengeList),
        .init(imageName: "gear", title: "Settings", type: .settings),
    ]
}
