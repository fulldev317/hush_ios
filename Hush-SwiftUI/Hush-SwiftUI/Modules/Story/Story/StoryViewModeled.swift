//
//  StoryViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

protocol StoryViewModeled: ObservableObject {
    var currentStoryIndex: Int { get set }
    var storyMessage: String { get set }
    var stories: [Image] { get }
    
    func showNext()
}

extension StoryViewModeled {
    var canTapNext: Bool {
        currentStoryIndex < stories.count - 1
    }
    
    func showNext() {
        currentStoryIndex += 1
    }
}
