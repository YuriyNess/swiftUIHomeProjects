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
    enum Errors: Error {
        case some(Error)
        case weakSelfChallengeService
    }
    
    private let db = FirebaseFirestore.Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(NSError()))
                return
            }
    
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge)
                promise(.success(Void()))
            } catch {
                promise(.failure(NSError()))
            }
        }.eraseToAnyPublisher()
    }
}
