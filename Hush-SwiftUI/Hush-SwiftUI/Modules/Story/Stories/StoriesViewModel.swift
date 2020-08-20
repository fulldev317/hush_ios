//
//  DiscoveryViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class StoriesViewModel: StoriesViewModeled {
    @Published var isShowingIndicator: Bool = false
    let settingsViewModel = StoriesSettingsViewModel()
    @Published var storyList: [Stories] = []
    @Published var myStoryList: [Story] = []

    @Published var selectedStoryIndex: Int = 0

    func uploadImage(userImage: UIImage, result: @escaping ( NSDictionary?, APIError?) -> Void)
    {
        UserAPI.shared.upload_image(image: userImage) { (imageUrls, error) in
            
            if error != nil {
                result(nil, error)
            } else {
                result(imageUrls, nil)
            }
        }
    }
    
    func uploadStory(imagePath: String, imageThumb: String, result: @escaping ( [Story?]?, APIError? ) -> Void)
    {
        StoryAPI.shared.upload_story(image_path: imagePath, image_thumb: imageThumb) { (upload_story, error) in
            if upload_story != nil {
                result(upload_story, error)
            } else {
                result(nil, error)
            }
        }
    }
    
    func viewStories(result: @escaping ( Bool ) -> Void)
    {
        self.storyList.removeAll()
        let addStory = Stories(id: "", profile_photo: "", profile_photo_big: "", city: "", country: "", address: "", age: "", fadeDelay: 0, video: 0, name: "", status: 0, story: "")
        self.storyList.append(addStory)
        
        StoryAPI.shared.view_stories() { (stories, error) in
            if error == nil {
                if let stories = stories {
                    for story in stories {
                        if let story = story {
                            self.storyList.append(story)
                        }
                    }
                }
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    func viewStory(userId: String, result: @escaping ( Bool ) -> Void)
    {
        myStoryList.removeAll()
        
        StoryAPI.shared.view_story(userId: userId) { (stories, error) in
            if error == nil {
                if let stories = stories {
                    for story in stories {
                        if let story = story {
                            self.myStoryList.append(story)
                        }
                    }
                }
                result(true)
            } else {
                result(false)
            }
        }
    }
}
