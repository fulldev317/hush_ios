//
//  MyStoryViewModel.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

class MyStoryViewModel: StoryViewModeled {
    @Published var currentStoryIndex: Int = 0
    @Published var storyMessage: String = ""
    @Published var stories: [Image] = []
    
    init(_ stories: [UIImage], isLastPick: Bool) {
        self.stories = stories.map(Image.init)
        if isLastPick {
            currentStoryIndex = self.stories.endIndex - 1
        }
    }
}
