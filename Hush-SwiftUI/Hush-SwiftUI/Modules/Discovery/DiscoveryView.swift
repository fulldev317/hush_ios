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
    
    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: -20) {
                ForEach(0..<10, id: \.self) {
                    self.row(at: $0)
                }
            }
        }
    }
     
    func row(at i: Int) -> some View {
        HStack(spacing: -18) {
            ForEach(0..<2, id: \.self) { j in
                PolaroidCard(
                    image: UIImage(named: "image3")!,
                    cardWidth: SCREEN_WIDTH / 2 + 15,
                    bottom: self.bottomView("")
                        .padding(.leading, self.leading(j))
                        .padding(.trailing, self.trailing(j))
                ).offset(x: j % 2 == 0 ? -10 : 10, y: 0)
                .zIndex(Double(i % 2 == 0 ? j : -j))
                .rotationEffect(.degrees(self.isRotated(i, j) ? 0 : -5), anchor: UnitPoint(x: 0.5, y: i % 2 == 1 ? 0.4 : 0.75))
            }
        }.zIndex(Double(100 - i))
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
        
//        VStack(spacing: 0) {
//            QGrid(viewModel.messages, columns: 2) { element in
//
//                NavigationLink(destination: UserProfileView(viewModel: UserProfileViewModel()).withoutBar()) {
//                    PolaroidCard(image: UIImage(named: "image3")!, cardWidth: SCREEN_WIDTH / 2, bottom: self.bottomView(element))
//                    .background(Rectangle().shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: -4))
//                    .rotate(self.viewModel.index(element).isMultiple(of: 3) ? 0 : -5)
//                }.buttonStyle(PlainButtonStyle())
//            }
//        }
    
    #warning("Please update viewModel")
    func bottomView(_ viewModel: String) -> some View {
        HStack {
            (Text("Emily") + Text(", ") + Text("\(29)")).font(.regular(14)).foregroundColor(Color(0x8E8786))
            if true {
                Spacer()
                Image("red_heart").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            } else {
                Spacer()
            }
        }.padding(15)
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
