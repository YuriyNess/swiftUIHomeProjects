//
//  DropdownExerciseOptions.swift
//  FitnessApp
//
//  Created by YuriyFpc on 15.01.2022.
//

import SwiftUI

struct DropdownExerciseOptions: Identifiable {
    var id = UUID()
    
    var options: [Option]
    
    var selectedOption: Option
    
    var headerTitle: String {
        type.rawValue
    }
    
    var title: String {
        selectedOption.formattedValue
    }
    
    var isSelected: Bool = false
    
    let type: DropdownExerciseOptionsType
    
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
        self.selectedOption = options.first!
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
        
        var number: Int? {
            switch type {
            case .numeric(let number):
                return number
            case .text(_):
                return nil
            }
        }
        
        var text: String? {
            switch type {
            case .numeric(_):
                return nil
            case .text(let text):
                return text
            }
        }
    }
    
    enum Exercises: String, CaseIterable {
        case pushUps = "Pushups"
        case pullUps = "Pullups"
        case sitDowns = "Sitdowns"
        
        var toOption: Option {
            .init(type: .text(rawValue), formattedValue: rawValue.uppercased())
        }
    }
    
    enum StartingAmaunt: Int, CaseIterable {
        case five = 5
        case ten = 10
        case twenty = 20
        case fourty = 40
        case sixty = 60
        
        var toOption: Option {
            .init(type: .numeric(rawValue), formattedValue: "\(rawValue)")
        }
    }
    
    enum DailyIncrease: Int, CaseIterable {
        case one = 1, two, three, four, five
        
        var toOption: Option {
            .init(type: .numeric(rawValue), formattedValue: "+\(rawValue)")
        }
    }
    
    enum ChallengeLength: Int, CaseIterable {
        case week = 7
        case twoWeeks = 14
        case threeWeeks = 21
        case month = 30
        
        var toOption: Option {
            .init(type: .numeric(rawValue), formattedValue: "\(rawValue) Days")
        }
    }
}
