//
//  CreateExerciseViewModel.swift
//  FitnessApp
//
//  Created by YuriyFpc on 05.01.2022.
//

import Combine
import Foundation

final class CreateExerciseViewModel: ObservableObject {
    private let userService = UserService()
    private let challengeService = ChallengeService()
    private var cancellables: [AnyCancellable] = []
    
    @Published var dropDownOptions: [DropdownExerciseOptions] = [
        .init(type: .exercise),
        .init(type: .amount),
        .init(type: .increase),
        .init(type: .length),
    ]
    
    func currentUserId() -> AnyPublisher<String, Error> {
        userService.currentUser.flatMap { user -> AnyPublisher<String, Error> in
            if let userId = user?.uid {
                debugPrint("user is already sign in")
                return Just(userId).setFailureType(to: Error.self).eraseToAnyPublisher()
            } else {
                debugPrint("user signInAnonymously")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

//MARK: - Actions
extension CreateExerciseViewModel {
    func addChallenge() {
        currentUserId().flatMap { userId in
            return self.createChallenge(userId: userId)
        }.sink { result in
            switch result {
            case .finished:
                debugPrint("createChallenge currentUserId completed")
            case .failure(let error):
                debugPrint(error)
            }
        } receiveValue: { _ in
            debugPrint("createChallenge success")
        }.store(in: &cancellables)
    }
    
    private func createChallenge(userId: String) -> AnyPublisher<Void, Error> {
        guard let exercise = dropDownOptions.first(where: { $0.type == .exercise })?.selectedOption.text,
              let startAmount = dropDownOptions.first(where: { $0.type == .amount })?.selectedOption.number,
              let increase = dropDownOptions.first(where: { $0.type == .increase })?.selectedOption.number,
              let length = dropDownOptions.first(where: { $0.type == .length })?.selectedOption.number else {
                  return Fail(error: NSError()).eraseToAnyPublisher()
              }
        
        let challenge = Challenge(userId: userId, exercise: exercise, startEmount: startAmount, increase: increase, length: length, startDate: Date())
        
        return challengeService.create(challenge)
    }
}
