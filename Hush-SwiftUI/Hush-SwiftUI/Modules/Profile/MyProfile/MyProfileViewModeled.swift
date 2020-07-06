//
//  MyProfileViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//
import UIKit
import Combine

protocol MyProfileViewModeled: ObservableObject {
    
    var message: String { get set }
    var basicsViewModel: BioViewMode { get set }
    
    var messageLabel: String { get set }
    var canGoToAR: Bool { get set }
    var canGoNext: Bool { get set }
    var selectedImage: UIImage? { get set }
    var photoDatas: [UIImage] { get set }
    var selectedIndex: Int { get set }
    var photoUrls: [String] { get set }
    var unlockedPhotos: Set<Int> { get set }

    var pickerSourceType: UIImagePickerController.SourceType { get set }
    var isPermissionDenied: Bool { get set }
    var isPickerPresented: Bool { get set }
    var isPickerSheetPresented: Bool { get set }
    var locations: [String] { get set }
    
    func appear()
    func disappear()
    func takePhoto()
    func cameraRoll()
    func addPhoto()
    
    func updateMessage()
    
    func logout(result: @escaping (Bool, String) -> Void)

}
