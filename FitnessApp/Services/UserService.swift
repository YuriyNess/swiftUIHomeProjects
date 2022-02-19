//
//  UserService.swift
//  FitnessApp
//
//  Created by YuriyFpc on 19.02.2022.
//

import Firebase
import Combine

final class UserService {
    enum Errors: Error {
        case some(Error)
        case signInAnonymously
    }
    
    var currentUser: AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    promise(.failure(Errors.some(error)))
                } else if let user = result?.user {
                    promise(.success(user))
                } else {
                    promise(.failure(Errors.signInAnonymously))
                }
            }
        }.eraseToAnyPublisher()
    }
}
