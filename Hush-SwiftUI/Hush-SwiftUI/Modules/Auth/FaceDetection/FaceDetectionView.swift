//
//  FaceDetectionView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 01.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct FaceDetectionView<ViewModel: FaceDetectionViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    #if (arch(i386) || arch(x86_64))
    @State var image = UIImage(named: "image3")
    @State var showGood = true
    #else
    @State var image: UIImage?
    @State var showGood = false
    #endif
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            #if !(arch(i386) || arch(x86_64))
            OldFD(image: $image, showGood: $showGood).edgesIgnoringSafeArea(.all)
            #endif
            if image != nil {
                NavigationLink(destination: GoodContainer(image: image!, name: "", username: "", email: "", password: "", photoModel: AddPhotosViewModel(name: "", username: "", email: "", password: ""), imagePath: "", imageThumb: "").withoutBar(), isActive: $showGood, label: {
                    Text("")
                })
            }
        }
    }
}
struct FaceDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                FaceDetectionView(viewModel: FaceDetectionViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                FaceDetectionView(viewModel: FaceDetectionViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                FaceDetectionView(viewModel: FaceDetectionViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}

struct OldFD: UIViewControllerRepresentable {
    
    var vc = UIStoryboard(name: "OldFaceDetection", bundle: nil).instantiateViewController(withIdentifier: "FacedetectorVC") as! FacedetectorVC
    
    @Binding var image: UIImage?
    @Binding var showGood: Bool
    
    func makeUIViewController(context: Context) -> FacedetectorVC {
        vc.completion = {
            self.image = $0
            self.showGood = true
        }
        return vc
    }
    
    func updateUIViewController(_ uiViewController: FacedetectorVC, context: Context) {
        
        
    }
}

struct OldGood: UIViewControllerRepresentable {
    
    var image: UIImage
    var photoModel: AddPhotosViewModel
    @Binding var canGoNext: Bool
    @Binding var imagePath: String
    @Binding var imageThumb: String
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> LookingGoodVC {
        
        LookingGoodVC.create(for: image, photoModel: photoModel, dismiss: presentationMode) { imageDic in
            if let dic = imageDic {
                
                self.imagePath = dic["path"] as! String
                self.imageThumb = dic["thumb"] as! String
                self.canGoNext.toggle()
            }
        }
    }
    
    func updateUIViewController(_ uiViewController: LookingGoodVC, context: Context) {
        
        
    }
}

struct GoodContainer: View, AuthAppScreens {
    
    var image: UIImage
    var name: String
    var username: String
    var email: String
    var password: String
    var photoModel: AddPhotosViewModel
    
    @State var imagePath: String
    @State var imageThumb: String
    @State var canGoNext = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
            OldGood(image: image, photoModel: photoModel, canGoNext: $canGoNext, imagePath: $imagePath, imageThumb: $imageThumb).edgesIgnoringSafeArea(.all)
            
            NavigationLink(destination: GetMoreDetailsView(viewModel: GetMoreDetailsViewModel(name: name, username: username, email: email, password: password, image: image, imagePath: imagePath, imageThumb: imageThumb)).withoutBar(), isActive: $canGoNext) {
                Text("")
            }
        }
    }
}
