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
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack(alignment: .bottom) {
            FaceDetectionViewController()
            ImagesRoll(viewModel: viewModel)
                .frame(width: UIScreen.main.bounds.width).frame(maxHeight: 240)
                .background(Color.black)
            if viewModel.expandedIndex != nil {
                VStack {
                    expanded().frame(width: viewModel.size)
                    Spacer()
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    
    func expanded() -> some View {
        ImagesRoll(viewModel: viewModel, isHorizontal: false)
    }
}

struct ImagesRoll<ViewModel: FaceDetectionViewModeled>: View, AuthAppScreens {
    
    @ObservedObject var viewModel: ViewModel
    var isHorizontal: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                UIScrollViewWrapper {
                    directionalStack {
                        ForEach(0 ..< viewModel.mainCategroyImageArr.count) { index in
                            HapticButton(action: {
                                self.viewModel.select(at: index)
                            }) {
                                self.viewModel.mainCategroyImageArr[index]
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: self.viewModel.size, height: self.viewModel.size)
                                    .shadow(color: .white, radius: 15, y: 4)
                            }
                        }
                    }
                    .padding(.top, 30)
                }.padding(.horizontal, 20)
                HStack(spacing: 10) {
                    borderedButton(action: {}, title: "Reset")
                    borderedButton(action: {}, title: "Done")
                }
                .padding(.bottom, 35).padding(.horizontal, 40)
            }
        }
    }
    
    func directionalStack<Content: View>(_ content: () -> Content) -> some View {
        
        if isHorizontal {
            return AnyView(HStack(spacing: 20, content: content))
        } else {
            return AnyView(VStack(spacing: 20, content: content))
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


class UIScrollViewViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.isPagingEnabled = true
        return v
    }()
    
    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        self.view.addSubview(self.scrollView)
        self.pinEdges(of: self.scrollView, to: self.view)
        
        self.hostingController.willMove(toParent: self)
        scrollView.contentInset = .init(top: 0, left: 30, bottom: 0, right: 30)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.addSubview(self.hostingController.view)
        self.pinEdges(of: self.hostingController.view, to: self.scrollView)
        self.hostingController.didMove(toParent: self)
        hostingController.view.backgroundColor = .clear
    }
    
    func pinEdges(of viewA: UIView, to viewB: UIView) {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.addConstraints([
            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
        ])
    }
    
}

struct UIScrollViewWrapper<Content: View>: UIViewControllerRepresentable {
    
    var content: Content
    
    init(@ViewBuilder content:  () -> Content) {
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> UIScrollViewViewController {
        let vc = UIScrollViewViewController()
        vc.hostingController.rootView = AnyView(content)
        return vc
    }
    
    func updateUIViewController(_ viewController: UIScrollViewViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(content)
    }
}
