//
//  ModalPresenterWrapper.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 11.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

private struct ModalPresenterWrapper: UIViewControllerRepresentable {
    let presenter: AnyView
    let modalPresenterManager = ModalPresenterManager()
    
    init<Presenter: View>(_ presenter: Presenter) {
        self.presenter = AnyView(presenter.environmentObject(modalPresenterManager))
    }
    
    func makeUIViewController(context: Context) -> UIHostingController<AnyView> {
        let controller = UIHostingController(rootView: presenter)
        context.coordinator.controller = controller
        modalPresenterManager.wrapperCoordinator = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<AnyView>, context: Context) {
        uiViewController.rootView = presenter
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: ObservableObject {
        var controller: UIViewController?
    }
}

class ModalPresenterManager: ObservableObject {
    fileprivate var wrapperCoordinator: ModalPresenterWrapper.Coordinator?
    
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, animated: Bool = true, completion: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        let contentViewController = UIHostingController(rootView: content().environmentObject(self))
        contentViewController.modalPresentationStyle = style
        present(style: style, controller: contentViewController, animated: animated, completion: completion)
    }
    
    func present(style: UIModalPresentationStyle = .automatic, controller: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        wrapperCoordinator?.controller?.present(controller, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)?) {
        wrapperCoordinator?.controller?.dismiss(animated: animated, completion: completion)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    var presenter: UIViewController? {
        wrapperCoordinator?.controller
    }
}

extension View {
    func hostModalPresenter() -> some View {
        ModalPresenterWrapper(self)
    }
}
