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
    @Published var userId: String = ""
    @Published var storyMessage: String = ""
    @Published var stories: [Story] = []
    @Published var isMyStory: Bool = false
    @Published var isShowingIndicator = false
    
    let canSendMessages = true
    let canReport = true
    
    init(stories: [Story], index: Int) {
        self.stories = stories
        self.currentStoryIndex = index
        if (stories.count > 0) {
            let story = stories[0]
            if let userId = story.uid {
                self.userId = userId
                let user = Common.userInfo()
                if let myUserId = user.id {
                    if userId == myUserId {
                        self.isMyStory = true
                    }
                }
            }
        }
    }
    
    func deleteStory() {
        let deleteIndex = currentStoryIndex
        let story = stories[deleteIndex]
        if let storyId = story.sid {
            isShowingIndicator = true
            StoryAPI.shared.delete_story(storyId: storyId) { (error) in
                self.isShowingIndicator = false
                if (error == nil) {
                    Common.setStoryUpdate(update: true)
                    if self.currentStoryIndex == self.stories.count - 1 {
                        self.currentStoryIndex -= 1
                    }
                    self.stories.remove(at: deleteIndex)
                }
            }
        }

    }
    
    func makePrimaryImage() {
        let story = stories[currentStoryIndex]
        if let storyId = story.sid {
            isShowingIndicator = true
            StoryAPI.shared.make_primary_image(storyId: storyId) { (error) in
                self.isShowingIndicator = false
                if (error == nil) {
                    Common.setStoryUpdate(update: true)
                    let story = self.stories[self.currentStoryIndex]
                    self.stories.remove(at: self.currentStoryIndex)
                    self.stories.insert(story, at: 0)
                    self.currentStoryIndex = 0
                }
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
        let path = story.icon ?? "empty"
        return path
    }
    
    func getStoryTitle() -> String {
        if (currentStoryIndex < 0 || currentStoryIndex >= stories.count) {
            return ""
        }
        let story = stories[currentStoryIndex]
        let title = story.title ?? ""
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
