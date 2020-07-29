//
//  DiscoveryViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import UIKit

protocol StoriesViewModeled: ObservableObject {
    associatedtype Settings: StoriesSettingsViewModeled
    var settingsViewModel: Settings { get }
    var isShowingIndicator: Bool { get set }
    var storyList: [Story] { get set }
    var selectedStoryIndex: Int { get set }
    func uploadImage(userImage: UIImage, result: @escaping ( NSDictionary?,  APIError?) -> Void)
    func uploadStory(imagePath: String, imageThumb: String, result: @escaping ( [Story?]?, APIError? ) -> Void)
    func viewStory(result: @escaping ( Bool ) -> Void)

}
