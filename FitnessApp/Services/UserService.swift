//
//  UserService.swift
//  FitnessApp
//
//  Created by YuriyFpc on 19.02.2022.
//

import Firebase
import Combine

final class UserService {
    var currentUser: AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func observeAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, FitnessError> {
        return Future<User, FitnessError> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    promise(.failure(FitnessError.auth(description: error.localizedDescription)))
                } else if let user = result?.user {
                    promise(.success(user))
                } else {
                    promise(.failure(FitnessError.auth()))
                }
            }
        }.eraseToAnyPublisher()
    }
}
