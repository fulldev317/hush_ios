//
//  DiscoveryView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import QGrid
import PartialSheet

var SafeAreaInsets: UIEdgeInsets {
    UIApplication.shared.windows.first?.rootViewController?.view.safeAreaInsets ?? .zero
}

protocol HeaderedScreen {
    
}

extension HeaderedScreen {
    
    func header<V: View>(_ list: [V]) -> some View {
        HStack {
            VStack(alignment: .leading) {
                
                ForEach(0..<list.count) {
                    list[$0]
                }
            }
            Spacer()
        }.padding(.leading, 30)
    }
}

struct StoriesView<ViewModel: StoriesViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @State var userStories: [UIImage] = []
    @EnvironmentObject var modalPresenterManager: ModalPresenterManager
    @EnvironmentObject var app: App
    private let imagePicker = DVImagePicker()
    
    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: -14) {
                ForEach(0...10, id: \.self) { i in
                    HStack(spacing: -2) {
                        ForEach(0..<3, id: \.self) { j in
                            UserStoryView(username: "Username", isMyStory: i == 0 && j == 0, isFirstStory: self.userStories.isEmpty, storyImage: self.userStories.last)
                                .rotationEffect(.degrees((i * 3 + j).isMultiple(of: 2) ? 0 : 5), anchor: .center)
                                .zIndex(j == 1 ? 3 : 0)
                                .offset(self.offset(row: i, column: j))
                                .onTapGesture { self.handleTap(i, j) }
                        }
                    }.zIndex(self.zIndex(row: i))
                    .padding(.horizontal, 22)
                    .frame(width: SCREEN_WIDTH)
                }
            }.padding(.top, 22)
        }
    }
    
    private func zIndex(row i: Int) -> Double {
        -Double(i)
    }
    
    private func offset(row i: Int, column j: Int) -> CGSize {
        let x: CGFloat
        switch (i, j) {
        case let (i, 0) where i != 0:
            x = -10
        case (0, 2):
            x = 5
        default:
            x = 0
        }
        
        return CGSize(width: x, height: 0)
    }
    
    func handleTap(_ i: Int, _ j: Int) {
        if i == 0 && j == 0 {
            showStoryPicker()
        } else {
            showStory()
        }
    }
    
    func showStory() {
        modalPresenterManager.present(style: .overFullScreen) {
            StoryView(viewModel: StoryViewModel()).environmentObject(self.app)
        }
    }
    
    func showMyStory(lastPick: Bool) {
        modalPresenterManager.present(style: .overFullScreen) {
            StoryView(viewModel: MyStoryViewModel(userStories, isLastPick: lastPick))
        }
    }
    
    func showStoryPicker() {
        let viewStory = UIAlertAction(title: "View Story", style: .default) { _ in self.showMyStory(lastPick: false) }
        let uploadStory = UIAlertAction(title: "Upload Story", style: .default) { _ in self.pickStory() }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        viewStory.isEnabled = !userStories.isEmpty
        let alert = TextAlert(style: .actionSheet, title: "Your Story Options", message: nil, actions: [
            viewStory,
            uploadStory,
            cancel
        ])
        
        modalPresenterManager.present(controller: UIAlertController(alert: alert))
    }
    
    func pickStory() {
        imagePicker.showActionSheet(from: modalPresenterManager.presenter!) { result in
            guard case let .success(image) = result else { return }
            self.userStories.append(image)
            self.modalPresenterManager.dismiss {
                self.showMyStory(lastPick: true)
            }
        }
    }
}

struct UserStoryView: View {
    let username: String
    let isMyStory: Bool
    let isFirstStory: Bool
    let storyImage: UIImage?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            VStack(spacing: 0) {
                GeometryReader { proxy in
                    (self.storyImage == nil || !self.isMyStory ? Image("stories_placeholder") : Image(uiImage: self.storyImage!))
                        .resizable()
                        .scaledToFill()
                }.clipped()
                .overlay(overlay)
                .padding(8)
                .aspectRatio(1, contentMode: .fit)
                
                Text(isMyStory ? "Your Story" : username)
                    .font(.light(14))
                    .foregroundColor(Color(0x8E8786))
            }
        }.aspectRatio(124 / 148, contentMode: .fit)
        .border(Color(0xE0E0E0), width: 1)
        .scaledToFill()
    }
    
    private var overlay: some View {
        Group {
            if isMyStory {
                Color.black.opacity(isFirstStory ? 1 : 0.7)
                    .overlay(Text("+")
                        .font(.system(.largeTitle))
                        .foregroundColor(.hOrange))
            } else {
                GeometryReader { p in
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image("image4")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: p.size.width / 2.4, height: p.size.height / 2.4)
                                .background(Circle().fill(Color.white).padding(-5))
                        }
                    }
                }
            }
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabBarView_Previews.previews
//        StoryView(username: "Username", isMyStory: false)
//            .frame(width: 124, height: 148)
//            .padding(50)
//            .previewLayout(.sizeThatFits)
//        Group {
//            NavigationView {
//                StoriesView(viewModel: StoriesViewModel())
//            }
//            NavigationView {
//                StoriesView(viewModel: StoriesViewModel())
//            }.previewDevice(.init(rawValue: "iPhone 8"))
//            NavigationView {
//                StoriesView(viewModel: StoriesViewModel())
//            }.previewDevice(.init(rawValue: "iPhone XS Max"))
//        }
    }
}
