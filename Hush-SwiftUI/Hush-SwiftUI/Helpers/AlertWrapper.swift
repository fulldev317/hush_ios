//
//  AlertWrapper.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 10.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

extension UIAlertController {
    convenience init(alert: TextAlert) {
        self.init(title: alert.title, message: alert.message, preferredStyle: alert.style)
        alert.actions.forEach(addAction(_:))
    }
}

extension UIAlertAction {
    convenience init(toggling: Binding<Bool>, title: String?, style: Style, handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: title, style: style) { action in
            handler?(action)
            toggling.wrappedValue.toggle()
        }
    }
}

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alert: TextAlert
    let content: Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }
    
    final class Coordinator {
        var alertController: UIAlertController?
        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
        uiViewController.rootView = content
        if isPresented && uiViewController.presentedViewController == nil {
            context.coordinator.alertController = UIAlertController(alert: alert)
            uiViewController.present(context.coordinator.alertController!, animated: true)
        }
        if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
    }
}

struct TextAlert {
    let style: UIAlertController.Style
    let title: String?
    let message: String?
    var actions: [UIAlertAction]
}

extension View {
    func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
        AlertWrapper(isPresented: isPresented, alert: alert, content: self)
    }
}
