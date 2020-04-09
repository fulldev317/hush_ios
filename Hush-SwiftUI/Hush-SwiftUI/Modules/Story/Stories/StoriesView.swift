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
    @State var showStorie = false
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack(spacing: 0) {
            QGrid(viewModel.messages, columns: 2) { element in
                
                HapticButton(action: {
                    self.showStorie.toggle()
                }, label: {
                    StoryCardsView(viewModel: StoryCardsViewModel())
                        .background(Rectangle().shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: -4))
                        .rotate(self.viewModel.index(element).isMultiple(of: 3) ? 0 : -5)
                }).sheet(isPresented: self.$showStorie, content: {
                    StorieView(viewModel: StorieViewModel())
                })
                
            }
            }.withoutBar().background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                StoriesView(viewModel: StoriesViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                StoriesView(viewModel: StoriesViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                StoriesView(viewModel: StoriesViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
