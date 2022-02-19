//
//  CreateExerciseViewModel.swift
//  FitnessApp
//
//  Created by YuriyFpc on 05.01.2022.
//

import Combine

final class CreateExerciseViewModel: ObservableObject {
    private let userService = UserService()
    private var cancellables: [AnyCancellable] = []
    
    @Published var dropDownOptions: [DropdownExerciseOptions] = [
        .init(type: .exercise),
        .init(type: .amount),
        .init(type: .increase),
        .init(type: .length),
    ]
    
    var currentUserId: AnyPublisher<String, Error> {
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
    
    var hasSelectedDropDowns: Bool {
        dropDownOptions.contains(where: { $0.isSelected })
    }
    
    var selectedDropDownsIndex: Int? {
        dropDownOptions.enumerated().first(where: { $0.element.isSelected })?.offset
    }
    
    var displayedOptions: [DropdownExerciseOptions.Option] {
        dropDownOptions.first(where: { $0.isSelected })?.options ?? []
    }
}

//MARK: - Actions
extension CreateExerciseViewModel {
    func selectOptionInSelectedDropdown(optionIndex: Int) {
        guard let selectedDropDownsIndex = selectedDropDownsIndex else { return }
        dropDownOptions[selectedDropDownsIndex].options.indices.forEach({ index in
            dropDownOptions[selectedDropDownsIndex].options[index].isSelected = false
        })
        dropDownOptions[selectedDropDownsIndex].options[optionIndex].isSelected = true
        dropDownOptions[selectedDropDownsIndex].isSelected = false
    }
    
    func createChallenge() {
        currentUserId.sink { result in
            switch result {
            case .finished:
                debugPrint("createChallenge currentUserId completed")
            case .failure(let error):
                debugPrint(error)
            }
        } receiveValue: { userId  in
            debugPrint("createChallenge userId = \(userId)")
        }.store(in: &cancellables)
    }
}
