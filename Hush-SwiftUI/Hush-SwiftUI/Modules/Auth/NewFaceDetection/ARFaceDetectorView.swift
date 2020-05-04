//
//  ARFaceDetectorView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 04.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct ARFaceDetectorView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .black
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct ARFaceDetectorView_Previews: PreviewProvider {
    static var previews: some View {
        ARFaceDetectorView()
    }
}
