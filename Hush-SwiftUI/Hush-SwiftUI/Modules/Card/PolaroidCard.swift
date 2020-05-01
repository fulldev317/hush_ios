//
//  PolaroidCard.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

struct Squere: Shape {
    
    let x: CGFloat
    let y: CGFloat
    let side: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Rectangle().path(in: .init(x: x, y: y, width: side, height: side))
    }
}

struct PolaroidCard<Content: View>: View {
    
    var image: UIImage
    var cardWidth: CGFloat
    var bottom: Content = EmptyView() as! Content
    
    private let cardDimention: CGFloat = 3.5 / 4.2
    private var height: CGFloat {
        cardWidth / cardDimention
    }
    private var imgSide: CGFloat {
        cardWidth * 3.1 / (3.5)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.white)
            VStack(spacing: 0) {
                Image(uiImage: image)
                    .aspectRatio()
                    .frame(width: imgSide, height: imgSide)
                    .padding([.leading, .top, .trailing], (cardWidth - imgSide) / 2)
                    .clipShape(Squere(x: (cardWidth - imgSide) / 2, y: (cardWidth - imgSide) / 2, side: imgSide))
                
                bottom
            }
        }.frame(width: cardWidth, height: height)
    }
}

struct UserCardView_Previews: PreviewProvider {
    
    static let name: String = "Yolanda"
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
                PolaroidCard(image: UIImage(named: "image3")!, cardWidth: 200, bottom: bottomView)
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                PolaroidCard(image: UIImage(named: "image3")!, cardWidth: 200, bottom: bottomView)
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                PolaroidCard(image: UIImage(named: "image3")!, cardWidth: 200, bottom: bottomView)
            }.previewDevice(.init(rawValue: "iPhone XS Max")).background(Color.black)
        }
    }
}