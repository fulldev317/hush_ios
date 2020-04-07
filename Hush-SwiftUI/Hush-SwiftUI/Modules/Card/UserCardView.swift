//
//  UserCardView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

let SCREEN_WIDTH = UIScreen.main.bounds.width

struct UserCardView<Content: View>: View {
    
    // MARK: - Properties
    
    var image: UIImage
    var bottomView: Content
    var size: CGSize
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                GeometryReader { proxy in
                    Image(uiImage: self.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width - 20)
                        .clipShape(Rectangle())
                        .padding([.top, .leading, .trailing], 10)
                }
                Spacer()
                bottomView
            }
        }.frame(width: size.width, height: size.height)
    }
}

struct UserCardView_Previews: PreviewProvider {
    
    static let name: String = ""
    static let isSelected = true
    static let age = 2
    static var bottomView: some View {
        HStack {
            (Text(name) + Text(", ") + Text("\(age)")).font(.regular(14)).foregroundColor(Color(0x8E8786))
            if isSelected {
                Spacer()
                Image("red_heart").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            } else {
                Spacer()
            }
        }.padding(15)
    }
    static var previews: some View {
        Group {
            NavigationView {
                UserCardView(image: UIImage(named: "image3")!, bottomView: bottomView, size: .init(width: 100, height: 100)).padding().padding().background(Color.black)
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                UserCardView(image: UIImage(named: "image3")!, bottomView: bottomView, size: .init(width: 100, height: 100)).padding().padding().background(Color.black)
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                UserCardView(image: UIImage(named: "image3")!, bottomView: bottomView, size: .init(width: 100, height: 100))
            }.previewDevice(.init(rawValue: "iPhone XS Max")).padding().padding().background(Color.black)
        }
    }
}
