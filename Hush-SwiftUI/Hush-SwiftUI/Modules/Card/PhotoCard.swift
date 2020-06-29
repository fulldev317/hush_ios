//
//  PolaroidCard.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct Squere1: Shape {
    
    let x: CGFloat
    let y: CGFloat
    let side: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Rectangle().path(in: .init(x: x, y: y, width: side, height: side))
    }
}

struct PhotoCard<Content: View>: View {
    
    var image: String
    var cardWidth: CGFloat
    var bottom: Content = EmptyView() as! Content
    var blured: Bool = false
    
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
                .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 4)
            VStack(spacing: 0) {
                AsyncImage(url: URL(string: image)!, cache: iOSApp.cache, placeholder: cardWidth > 120 ? Image("placeholder_b") : Image("placeholder_s")) { image in
                    image.resizable()

                }
                .aspectRatio(contentMode: .fill)
                .frame(width: imgSide, height: imgSide)
                .padding([.leading, .top, .trailing], (cardWidth - imgSide) / 2)
                .blur(radius: blured ? (cardWidth - imgSide) / 3 : 0)
                .clipShape(Squere1(x: (cardWidth - imgSide) / 2, y: (cardWidth - imgSide) / 2, side: imgSide))
//
//                Image(uiImage: image)
//                    .aspectRatio()
//                    .overlay(overlay)
//                    .frame(width: imgSide, height: imgSide)
//                    .padding([.leading, .top, .trailing], (cardWidth - imgSide) / 2)
//                    .blur(radius: blured ? (cardWidth - imgSide) / 3 : 0)
//          `          .clipShape(Squere(x: (cardWidth - imgSide) / 2, y: (cardWidth - imgSide) / 2, side: imgSide))
                
                bottom
            }
        }.frame(width: cardWidth, height: height)
    }
}

extension PhotoCard {
    init<Overlay: View>(image: UIImage, cardWidth: CGFloat, overlay: Overlay) {
        self.init(image: "image", cardWidth: cardWidth, bottom: EmptyView() as! Content)
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    
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
