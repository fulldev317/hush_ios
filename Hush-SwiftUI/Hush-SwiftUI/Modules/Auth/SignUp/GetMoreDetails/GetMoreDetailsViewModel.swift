//
//  GetMoreDetailsViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class GetMoreDetailsViewModel: GetMoreDetailsViewModeled {
    
    // MARK: - Properties
    
    @Published var whatFors: [String] = ["Fun", "Chat", "Hookup", "Date"]
    @Published var selectedWhatFor: Set<Int> = []
    
    @Published var genders: [String] = ["Male", "Female", "A Couple", "Gay"]
    @Published var selectedGender: Int = 0
    
    @Published var lookingFors: [String] = ["Males", "Females", "Couples", "Gays"]
    @Published var selectedLookingFors: Set<Int> = []
    
    @Published var birthday: String = ""
    
    func updateMessage() {

        
    }
}
