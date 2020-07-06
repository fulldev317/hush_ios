//
//  AddPhotosViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import UIKit

protocol AddPhotosViewModeled: ObservableObject {
    
    var messageLabel: String { get set }
    var canGoToAR: Bool { get set }
    var canGoNext: Bool { get set }
    var selectedImage: UIImage? { get set }
    
    var pickerSourceType: UIImagePickerController.SourceType { get set }
    var isPermissionDenied: Bool { get set }
    var isPickerPresented: Bool { get set }
    var isPickerSheetPresented: Bool { get set }
    
    func appear()
    func disappear()
    func takePhoto()
    func cameraRoll()
    func addPhoto()
    func resetPhotoCamera()
    
    // data from previous screens
    var name: String { get set }
    var username: String { get set }
    var email: String { get set }
    var password: String { get set }
    
}
