//
//  ChallengeModel.swift
//  FitnessApp
//
//  Created by YuriyFpc on 06.03.2022.
//

import Foundation

struct Challenge: Codable {
    let userId: String
    let exercise: String
    let startEmount: Int
    let increase: Int
    let length: Int
    let startDate: Date
}
