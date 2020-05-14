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

struct DiscoveryView<ViewModel: DiscoveryViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @State private var showsUserProfile = false
    
    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: -20) {
                ForEach(0..<(viewModel.discoveries.count / 2), id: \.self) {
                    self.row(at: $0)
                }
            }.padding(.top, 10)
        }.background(
            NavigationLink(
                destination: UserProfileView(viewModel: UserProfileViewModel()),
                isActive: $showsUserProfile,
                label: EmptyView.init
            )
        )
    }
     
    func row(at i: Int) -> some View {
        HStack(spacing: -18) {
            ForEach(0..<2, id: \.self) { j in
                self.polaroidCard(i, j).tapGesture(toggls: self.$showsUserProfile)
            }
        }.zIndex(Double(100 - i))
    }
    
    func polaroidCard(_ i: Int, _ j: Int) -> some View {
        PolaroidCard(
            image: UIImage(named: "image3")!,
            cardWidth: SCREEN_WIDTH / 2 + 15,
            bottom: self.bottomView(i, j)
        ).offset(x: j % 2 == 0 ? -10 : 10, y: 0)
        .zIndex(Double(i % 2 == 0 ? j : -j))
        .rotationEffect(.degrees(self.isRotated(i, j) ? 0 : -5), anchor: UnitPoint(x: 0.5, y: i % 2 == 1 ? 0.4 : 0.75))
    }
    
    func leading(_ j: Int) -> CGFloat {
        j % 2 == 0 ? 25 : 0
    }
    
    func trailing(_ j: Int) -> CGFloat {
        j % 2 == 0 ? 0 : 23
    }
    
    func isRotated(_ i: Int, _ j: Int) -> Bool {
        let index = i * 2 + j
        return index % 4 == 0 || stride(from: 3, through: index, by: 4).contains(index)
    }
    
    #warning("Please update viewModel")
    func bottomView(_ i: Int, _ j: Int) -> some View {
        let discovery = viewModel.discovery(i, j)
        return HStack {
            (Text(discovery.name) + Text(", ") + Text("\(discovery.age)"))
                .font(.regular(14))
                .foregroundColor(Color(0x8E8786))
            Spacer()
            Button(action: { self.viewModel.like(i, j) }) {
                Image("red_heart")
                    .resizable()
                    .renderingMode(discovery.liked ? .original : .template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
            }
        }.padding(15)
        .padding(.leading, self.leading(j))
        .padding(.trailing, self.trailing(j))
    }
    
    
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DiscoveryView(viewModel: DiscoveryViewModel())
        }
//        Group {
//            NavigationView {
//                DiscoveryView(viewModel: DiscoveryViewModel())
//            }.previewDevice(.init(rawValue: "iPhone SE"))
//            NavigationView {
//                DiscoveryView(viewModel: DiscoveryViewModel())
//            }.previewDevice(.init(rawValue: "iPhone 8"))
//            NavigationView {
//                DiscoveryView(viewModel: DiscoveryViewModel())
//            }.previewDevice(.init(rawValue: "iPhone XS Max"))
//        }
    }
}
