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
    var stories: [Story] { get set }
    func uploadImage(userImage: UIImage, result: @escaping ( NSDictionary? ) -> Void)
    func uploadStory(imagePath: String, imageThumb: String, result: @escaping ( Stories? ) -> Void)
    func viewStory(result: @escaping ( Bool ) -> Void)

}
