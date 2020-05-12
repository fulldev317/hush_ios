//
//  CardCaruselTutorialView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct CardCaruselTutorialView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
            HStack {
                Image("tutor_cross_big")
                Spacer()
                Image("tutor_heart")
            }.padding(.leading, -13)
                .padding(.trailing, -40)
            
            Image("swipe_hand")
            .offset(x: -12, y: 130)
        }.overlay(Image("tutor_cross").padding(), alignment: .topTrailing)
    }
}

struct CardCaruselTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        CardCaruselTutorialView()
    }
}
