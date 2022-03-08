//
//  ChallengeService.swift
//  FitnessApp
//
//  Created by YuriyFpc on 06.03.2022.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ChallengeService {
    private let db = FirebaseFirestore.Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, FitnessError> {
        return Future<Void, FitnessError> { [weak self] promise in
            guard let self = self else {
                promise(.failure(.default()))
                return
            }
    
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(FitnessError.default(description: error.localizedDescription)))
                    } else {
                        promise(.success(Void()))
                    }
                }
            } catch {
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
}
