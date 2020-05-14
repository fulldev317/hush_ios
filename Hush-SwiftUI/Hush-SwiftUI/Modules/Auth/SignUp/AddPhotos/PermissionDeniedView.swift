//
//  PermissionDeniedView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 02.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct PermissionDeniedView: View, AuthAppScreens {
    let type: UIImagePickerController.SourceType
    @Environment(\.presentationMode) private var presentation
    @Environment(\.deviceScale) private var scale
    
    private var accessSource: String {
        switch type {
        case .camera:
            return "Camera"
        case .photoLibrary, .savedPhotosAlbum:
            return "Camera Roll"
        @unknown default:
            return "\(self)".capitalized
        }
    }
    
    var body: some View {
        ZStack {
            onBackButton(presentation)
            VStack(spacing: 26 * scale) {
                logo()
                    .padding(.top, 55 * scale)
                
                Spacer()
                Text("Whoops!")
                    .font(.thin(22 * scale))
                    .foregroundColor(.white)
                
                Group {
                    Text("You tapped “Don’t Allow” so we need to\ntake you to settings and ask you to manually\nallow hush access to your \(accessSource).")
                        .kerning(1)
                    
                    Text("You can always change it after if you wish.")
                    .kerning(1)
                    
                    Text("Please return to hush afterwards to continue")
                        .foregroundColor(.white)
                    .kerning(1)
                }.font(.thin(18 * scale))
                    
                .foregroundColor(Color(UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)))
                
                borderedButton(action: goToSettings, title: "Go to Settings")
                    .padding(.horizontal, 32 * scale)
                Spacer()
            }.multilineTextAlignment(.center)
        }.background(background())
    }
    
    private func goToSettings() {
        URL(string: UIApplication.openSettingsURLString).map {
            UIApplication.shared.open($0, options: [:], completionHandler: nil)
        }
    }
}

struct PermissionDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PermissionDeniedView(type: .camera).withoutBar()
        }
    }
}
