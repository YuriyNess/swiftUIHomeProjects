//
//  TabItemModel.swift
//  FitnessApp
//
//  Created by YuriyFpc on 13.03.2022.
//

struct TabItemModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case log
        case challengeList
        case settings
    }
}
