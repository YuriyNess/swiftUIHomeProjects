//
//  CreateExerciseViewModel.swift
//  FitnessApp
//
//  Created by YuriyFpc on 05.01.2022.
//

import Combine

final class CreateExerciseViewModel: ObservableObject {
    @Published var dropDownOptions: [DropdownExerciseOptions] = [
        .init(type: .exercise),
        .init(type: .amount),
        .init(type: .increase),
        .init(type: .length),
    ]
    
    var hasSelectedDropDowns: Bool {
        dropDownOptions.contains(where: { $0.isSelected })
    }
    
    var selectedDropDownsIndex: Int? {
        dropDownOptions.enumerated().first(where: { $0.element.isSelected })?.offset
    }
    
    var displayedOptions: [DropdownExerciseOptions.Option] {
        dropDownOptions.first(where: { $0.isSelected })?.options ?? []
    }
    
    func selectOptionInSelectedDropdown(optionIndex: Int) {
        guard let selectedDropDownsIndex = selectedDropDownsIndex else { return }
        dropDownOptions[selectedDropDownsIndex].options.indices.forEach({ index in
            dropDownOptions[selectedDropDownsIndex].options[index].isSelected = false
        })
        dropDownOptions[selectedDropDownsIndex].options[optionIndex].isSelected = true
        dropDownOptions[selectedDropDownsIndex].isSelected = false
    }
}
