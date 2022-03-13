//
//  QuarySnapshotPublisher.swift
//  FitnessApp
//
//  Created by YuriyFpc on 13.03.2022.
//

import Combine
import Firebase
import Foundation

extension Publishers {
    struct QuarySnapshotPublisher: Publisher {
        typealias Output = QuerySnapshot
        typealias Failure = FitnessError
        
        private let query: Query
        
        init(query: Query) {
            self.query = query
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, QuerySnapshot == S.Input {
            let subscription = QuerySnapshotSubscription(subscriber: subscriber, query: query)
            subscriber.receive(subscription: subscription)
        }
    }
    
    final class QuerySnapshotSubscription<S: Subscriber>: Subscription where S.Input == QuerySnapshot, S.Failure == FitnessError {
        
        private let subscriber: S?
        private var listener: ListenerRegistration
        
        init(subscriber: S, query: Query) {
            self.subscriber = subscriber
            listener = query.addSnapshotListener { snapshot, error in
                if let error = error {
                    subscriber.receive(completion: .failure(FitnessError.default(description: error.localizedDescription)))
                } else if let snapshot = snapshot {
                    _ = subscriber.receive(snapshot)
                } else {
                    subscriber.receive(completion: .failure(FitnessError.default()))
                }
            }
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {}
    }
}
