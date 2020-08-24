//
//  ImagesCarusel.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct UpgradeUIItem<Content: View>: Equatable {
    var title: String
    var content: Content
    
    static func == (_ l: Self, _ r: Self) -> Bool {
        l.title == r.title
    }
}

struct ImagesCarusel<Content: View>: View {
    
    var uiElements: [UpgradeUIItem<Content>]
    @State var current: Int = 0
    
    var body: some View {
        
        VStack {
            Text(uiElements[current].title)
                .font(.bold(24))
                .foregroundColor(.white)
                .animation(.easeInOut(duration: 0.3))
            Pager(page: $current, data: uiElements, id: \.title) { item in
                
                item.content.frame(width: 202, height: 164).centred
            }.onPageChanged { page in
                UISelectionFeedbackGenerator().selectionChanged()
                withAnimation {
                    self.current = page
                }
            }
            .itemSpacing(10)
            .padding(20)
            .frame(height: 164)
            HStack {
                ForEach(0..<uiElements.count) {
                    Circle().foregroundColor( $0 == self.current ? .hOrange : Color.white.opacity(0.3)).frame(width: 10, height: 10)
                }
            }.padding(.top, 20)
            Spacer()
        }.frame(width: 320, height: 254)
    }
}

struct ImagesCarusel_Previews: PreviewProvider {
    
    @State static var current = 0
    
    static var previews: some View {
        ImagesCarusel(uiElements: [
            UpgradeUIItem(title: "1", content: Image("image3")),
            UpgradeUIItem(title: "2", content: Image("image3")),
            UpgradeUIItem(title: "3", content: Image("image3")),
            UpgradeUIItem(title: "4", content: Image("image3")),
            UpgradeUIItem(title: "5", content: Image("image3")),
            UpgradeUIItem(title: "6", content: Image("image3")),
            UpgradeUIItem(title: "7", content: Image("image3")),
            UpgradeUIItem(title: "8", content: Image("image3"))
        ]).colorScheme(.dark)
    }
}
