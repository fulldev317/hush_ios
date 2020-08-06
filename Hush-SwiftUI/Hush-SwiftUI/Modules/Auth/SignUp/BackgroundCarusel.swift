//
//  ImagesCarusel.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct BGUIItem<Content: View>: Equatable {
    var title: String
    var content: Content
    
    static func == (_ l: Self, _ r: Self) -> Bool {
        l.title == r.title
    }
}

struct BackgroundCarusel<Content: View>: View {
    
    var uiElements: [BGUIItem<Content>]
    @State var current: Int = 0
    
    var body: some View {
        
        VStack {

            Pager(page: $current, data: uiElements, id: \.title) { item in
                
                item.content.frame(width: 375, height: 667).centred
            }
            .onPageChanged { page in
                UISelectionFeedbackGenerator().selectionChanged()
                withAnimation {
                    self.current = page
                }
            }
            .frame(width: 375, height: 667)
          
        }.frame(width: 375, height: 667)
    }
}

struct BackgroundCarusel_Previews: PreviewProvider {
    
    @State static var current = 0
    
    static var previews: some View {
        BackgroundCarusel(uiElements: [
            BGUIItem(title: "1", content: Image("back-1")),
        ]).colorScheme(.dark)
    }
}
