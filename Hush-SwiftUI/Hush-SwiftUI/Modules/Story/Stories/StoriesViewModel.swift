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
    @Published var storyList: [Story] = []
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
    
    func viewStory(result: @escaping ( Bool ) -> Void)
    {
        StoryAPI.shared.view_story() { (stories, error) in
            if error == nil {
                if stories != nil {
                    self.storyList.removeAll()
                    for story in stories! {
                        self.storyList.append(story!)
                    }
                } else {
                }
                result(true)
            } else {
                result(false)
            }
        }
    }
}
