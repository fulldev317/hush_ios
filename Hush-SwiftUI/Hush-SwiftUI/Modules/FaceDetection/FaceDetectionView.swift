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
    @State var image: UIImage?
    @State var showGood = true
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            OldFD(image: $image).edgesIgnoringSafeArea(.all)
            if image != nil {
                NavigationLink(destination: GoodContainer(image: image!), isActive: $showGood, label: {
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
    
    func makeUIViewController(context: Context) -> FacedetectorVC {
        vc.completion = {
            self.image = $0
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: FacedetectorVC, context: Context) {

        
    }
}

struct OldGood: UIViewControllerRepresentable {
    
    var image: UIImage
    
    func makeUIViewController(context: Context) -> LookingGoodVC {
        
        LookingGoodVC.create(for: image)
    }

    func updateUIViewController(_ uiViewController: LookingGoodVC, context: Context) {

        
    }
}

struct GoodContainer: View  {
    
    var image: UIImage
    
    var body: some View {
        OldGood(image: image)
    }
}
