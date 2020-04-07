//
//  ImagesCarusel.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct UpgradeUIItem: Equatable {
    var title: String
    var image: UIImage
    
    static func == (_ l: Self, _ r: Self) -> Bool {
        l.title == r.title
    }
}

struct ImagesCarusel: View {
    
    var uiElements: [UpgradeUIItem]
    @State var current: Int = 2
    
    var body: some View {
        
        VStack {
            Text(uiElements[current].title)
                .font(.bold(24))
                .foregroundColor(.white)
                .animation(.easeInOut(duration: 0.3))
            Pager(page: $current, data: uiElements, id: \.title) { item in
                
                Image(uiImage: item.image)
                .aspectRatio()
                    .frame(width: 120, height: 130).centred
            }.onPageChanged { page in
                UISelectionFeedbackGenerator().selectionChanged()
                withAnimation {
                    self.current = page
                }
            }
            .itemSpacing(10)
            .padding(20)
            .frame(height: 130)
            HStack {
                ForEach(0..<uiElements.count) {
                    Circle().foregroundColor( $0 == self.current ? .hOrange : Color.white.opacity(0.3)).frame(width: 10, height: 10)
                }
            }.padding(.top, 20)
            Spacer()
        }.background(Color.hBlack.edgesIgnoringSafeArea(.all))
    }
}

struct ImagesCarusel_Previews: PreviewProvider {
    
    @State static var current = 0
    
    static var previews: some View {
        ImagesCarusel(uiElements: [
            UpgradeUIItem(title: "1", image: UIImage(named: "image3")!),
            UpgradeUIItem(title: "2", image: UIImage(named: "image3")!),
            UpgradeUIItem(title: "3", image: UIImage(named: "image3")!),
            UpgradeUIItem(title: "4", image: UIImage(named: "image3")!),
            UpgradeUIItem(title: "5", image: UIImage(named: "image3")!),
            UpgradeUIItem(title: "6", image: UIImage(named: "image3")!),
            UpgradeUIItem(title: "7", image: UIImage(named: "image3")!),
            UpgradeUIItem(title: "8", image: UIImage(named: "image3")!)
            ])
    }
}
