//
//  StoryViewModel.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

class StoryViewModel: StoryViewModeled {
    @Published var currentStoryIndex: Int = -1
    @Published var storyMessage: String = ""
    @Published var stories: [Story] = []
    let canSendMessages = true
    let canReport = true
    
    init(stories: [Story], index: Int) {
        self.stories = stories
        self.currentStoryIndex = index
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
        let path = story.icon ?? "empty"
        return path
    }
    
    func getStoryTitle() -> String {
        if (currentStoryIndex < 0 || currentStoryIndex >= stories.count) {
            return "Unknown"
        }
        let story = stories[currentStoryIndex]
        let title = story.title ?? "Unknown"
        return title
    }
        
    func getStoryTime() -> String {
        if (currentStoryIndex < 0 || currentStoryIndex >= stories.count) {
            return ""
        }
        let story = stories[currentStoryIndex]
        let date = story.date ?? ""
        return date
    }
}
