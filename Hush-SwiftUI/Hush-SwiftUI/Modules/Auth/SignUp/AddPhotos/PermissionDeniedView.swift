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
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            onBackButton(presentation)
            VStack(spacing: 26) {
                logo()
                    .padding(.top, 55)
                    .padding(.bottom, 95)
                Text("Whoops!")
                    .font(.thin(22))
                    .foregroundColor(.white)
                Text("You tapped “Don’t Allow” so we need to take you to settings quick to allow us access to your Camera Roll.")
                    .font(.thin(18))
                    .foregroundColor(Color(UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)))
                    .frame(width: 300)
                Text("Then  please return to the app and continue")
                    .font(.thin(22))
                    .foregroundColor(.white)
                borderedButton(action: goToSettings, title: "Go to Settings")
                    .padding(.horizontal, 32)
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
        Group {
            NavigationView {
                PermissionDeniedView(type: .camera).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
            NavigationView {
                PermissionDeniedView(type: .camera).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                PermissionDeniedView(type: .camera).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
        }
    }
}
