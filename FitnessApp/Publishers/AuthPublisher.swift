//
//  AuthPublisher.swift
//  FitnessApp
//
//  Created by YuriyFpc on 08.03.2022.
//

import FirebaseAuth
import Combine

extension Publishers {
    class AuthPublisher: Publisher {
        typealias Output = User?
        typealias Failure = Never
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let authSubscription = AuthSubscription(subscriber: subscriber)
            subscriber.receive(subscription: authSubscription)
        }
    }
    
    class AuthSubscription<S: Subscriber>: Subscription where S.Input == User?, S.Failure == Never {
        var combineIdentifier = CombineIdentifier()
        private var subscriber: S?
        private var authHandler: AuthStateDidChangeListenerHandle?
        
        init(subscriber: S) {
            self.subscriber = subscriber
            self.authHandler = Auth.auth().addStateDidChangeListener { auth, user in
                _ = subscriber.receive(user)
            }
        }
        

        func request(_ demand: Subscribers.Demand) {
        }
        
        func cancel() {
            subscriber = nil
            authHandler = nil
        }
    }
}
