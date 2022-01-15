//
//  CreateExerciseViewModel.swift
//  FitnessApp
//
//  Created by YuriyFpc on 05.01.2022.
//

import Foundation

struct DropdownExerciseOptions {
    var options: [Option]
    
    var headerTitle: String {
        type.rawValue
    }
    
    var title: String {
        options.first(where: { $0.isSelected })?.formattedValue ?? ""
    }
    
    private let type: DropdownExerciseOptionsType
    
    init(type: DropdownExerciseOptionsType) {
        self.type = type
        switch type {
        case .exercise:
            options = Exercises.allCases.map({ $0.toOption })
        case .amount:
            options = StartingAmaunt.allCases.map({ $0.toOption })
        case .increase:
            options = DailyIncrease.allCases.map({ $0.toOption })
        case .length:
            options = ChallengeLength.allCases.map({ $0.toOption })
        }
    }
}

//MARK: - Internal Types
extension DropdownExerciseOptions {
    enum DropdownExerciseOptionsType: String {
        case exercise = "Exercise"
        case amount = "Starting Amount"
        case increase = "Daily Increase"
        case length = "Challenge Length"
    }
    
    struct Option {
        enum OptionType {
            case numeric(Int)
            case text(String)
        }
        
        var type: OptionType
        var formattedValue: String
        var isSelected: Bool
    }
    
    enum Exercises: String, CaseIterable {
        case pushUps = "Pushups"
        case pullUps = "Pullups"
        case sitDowns = "Sitdowns"
        
        var toOption: Option {
            .init(type: .text(rawValue), formattedValue: rawValue.uppercased(), isSelected: self == .pushUps)
        }
    }
    
    enum StartingAmaunt: Int, CaseIterable {
        case five = 5
        case ten = 10
        case twenty = 20
        case fourty = 40
        case sixty = 60
        
        var toOption: Option {
            .init(type: .numeric(rawValue), formattedValue: "\(rawValue)", isSelected: self == .five)
        }
    }
    
    enum DailyIncrease: Int, CaseIterable {
        case one = 1, two, three, four, five
        
        var toOption: Option {
            .init(type: .numeric(rawValue), formattedValue: "+\(rawValue)", isSelected: self == .one)
        }
    }
    
    enum ChallengeLength: Int, CaseIterable {
        case week = 7
        case twoWeeks = 14
        case threeWeeks = 21
        case month = 30
        
        var toOption: Option {
            .init(type: .numeric(rawValue), formattedValue: "\(rawValue) Days", isSelected: self == .week)
        }
    }
}

final class CreateExerciseViewModel: ObservableObject {
    @Published var dropDownOptions: [DropdownExerciseOptions] = [
        .init(type: .exercise),
        .init(type: .amount),
        .init(type: .increase),
        .init(type: .length),
    ]
}
