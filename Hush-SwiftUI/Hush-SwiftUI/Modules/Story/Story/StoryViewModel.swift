//
//  StoryViewModel.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

class StoryViewModel: StoryViewModeled {
    @Published var currentStoryIndex: Int = 0
    @Published var storyMessage: String = ""
    @Published var stories: [Image] = ["stories_placeholder", "story1", "story2", "story3"].map { Image($0) } 
}
