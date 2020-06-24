//
//  MatchView.swift
//  Hush-SwiftUI
//
//  Created Maksym on 06.08.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import QGrid
import PartialSheet

struct MatchView<ViewModel: MatchViewModeled>: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: ViewModel
    let title: String
    let image_url: String
    let blured: Bool
    
    @State private var showsUserProfile = false
    @State private var showUpgrade = false
    @Environment(\.presentationMode) var mode


    // MARK: - Lifecycle
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(title).font(.thin(48)).foregroundColor(.hOrange)
                HStack(alignment: .top) {
                   HapticButton(action: { self.mode.wrappedValue.dismiss() }) {
                       HStack(spacing: 23) {
                           Image("onBack_icon")
                           Text("Back to My Profile").foregroundColor(.white).font(.thin())
                       }
                   }
                   Spacer()
                }
            }.padding([.horizontal])
               
            ScrollView(showsIndicators: false) {
                VStack(spacing: -20) {
                  ForEach(0..<(viewModel.matches.count / 2), id: \.self) {
                      self.row(at: $0)
                  }
                }.padding(.top, 10)
            }.background(
                NavigationLink(
                    destination: UserProfileView(viewModel: UserProfileViewModel(user: nil)),
                  isActive: $showsUserProfile,
                  label: EmptyView.init
                )
            ).background(
                NavigationLink(
                    destination: UpgradeView(viewModel: UpgradeViewModel()).withoutBar(),
                    isActive: $showUpgrade,
                    label: EmptyView.init
                )
                
            )
       }
       .background(Color.hBlack.edgesIgnoringSafeArea(.all))
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
            image: UIImage(named: image_url)!,
            cardWidth: SCREEN_WIDTH / 2 + 15,
            bottom: self.bottomView(i, j),
            blured: blured
        ).offset(x: j % 2 == 0 ? -10 : 10, y: 0)
        .zIndex(Double(i % 2 == 0 ? j : -j))
        .rotationEffect(.degrees(self.isRotated(i, j) ? 0 : -5), anchor: UnitPoint(x: 0.5, y: i % 2 == 1 ? 0.4 : 0.75))
        .onTapGesture {
            if (self.blured) {
                self.showUpgrade.toggle()
            }
        }
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
        let match = viewModel.match(i, j)
        return HStack {
            (Text(match.name) + Text(", ") + Text("\(match.age)"))
                .font(.regular(14))
                .blur(radius: blured ? 2 : 0)
                .foregroundColor(Color(0x8E8786))
            Spacer()
            Button(action: { self.viewModel.like(i, j) }) {
                Image("red_heart")
                    .resizable()
                    .renderingMode(match.liked ? .original : .template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
            }
        }.padding(15)
        .padding(.leading, self.leading(j))
        .padding(.trailing, self.trailing(j))
    }
    
    
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchView(viewModel: MatchViewModel(), title: "Matches", image_url: "image1", blured: true)
        }
    }
}
