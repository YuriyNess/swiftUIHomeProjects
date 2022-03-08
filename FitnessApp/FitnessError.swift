//
//  FitnessError.swift
//  FitnessApp
//
//  Created by YuriyFpc on 08.03.2022.
//

import Foundation

enum FitnessError: LocalizedError {
    case auth(description: String? = nil)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
            
        case    .auth(description: let description),
                .default(description: let description):
            
            return description ?? "Something went wrong"
        }
    }
}
