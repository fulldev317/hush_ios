//
//  MyStoryViewModel.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

class MyStoryViewModel: StoryViewModeled {
    func deleteStory() {
        <#code#>
    }
    
    func makePrimaryImage() {
        <#code#>
    }
    
    
    
    @Published var currentStoryIndex: Int = 0
    @Published var storyMessage: String = ""
    @Published var stories: [Story] = []
    let canSendMessages = false
    let canReport = false
    
    init(_ stories: [UIImage], isLastPick: Bool) {
        self.stories = []
        if isLastPick {
            currentStoryIndex = self.stories.endIndex - 1
            if (currentStoryIndex < 0) {
                currentStoryIndex = 0
            }
        }
    }
    
    func getStoryImagePath() -> String {
        if (currentStoryIndex < 0 || currentStoryIndex >= stories.count) {
            return "empty"
        }
        let story = stories[currentStoryIndex]
        let url = story.url ?? "empty"
        return url
    }
    
    
    func getStoryAvatarPath() -> String {
        if (currentStoryIndex < 0 || currentStoryIndex >= stories.count) {
            return "empty"
        }
        let story = stories[currentStoryIndex]
        let url = story.icon ?? "empty"
        return url
    }
    
    func getStoryTitle() -> String {
        if (currentStoryIndex < 0 || currentStoryIndex >= stories.count) {
            return ""
        }
        let story = stories[currentStoryIndex]
        let url = story.title ?? ""
        return url
    }
    
    func getStoryTime() -> String {
        if (currentStoryIndex < 0 || currentStoryIndex >= stories.count) {
            return ""
        }
        let story = stories[currentStoryIndex]
        let url = story.date ?? ""
        return url
    }
}
