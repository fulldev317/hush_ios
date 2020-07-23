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
    @Published var stories: [Story] = []

    func uploadImage(userImage: UIImage, result: @escaping ( NSDictionary?) -> Void)
    {
        UserAPI.shared.upload_image(image: userImage) { (imageUrls, error) in
            
            if error != nil {
                result(nil)
            } else {
                result(imageUrls)
            }
        }
    }
    
    func uploadStory(imagePath: String, imageThumb: String, result: @escaping ( Stories? ) -> Void)
    {
        StoryAPI.shared.upload_story(image_path: imagePath, image_thumb: imageThumb) { (upload_story) in
            if upload_story != nil {
                result(upload_story)
            } else {
                result(nil)
            }
        }
    }
    
    func viewStory(result: @escaping ( Bool ) -> Void)
    {
        StoryAPI.shared.view_story() { (upload_story) in
            if upload_story != nil {
                self.stories = upload_story!.stories!
            } else {
            }
        }
    }
}
