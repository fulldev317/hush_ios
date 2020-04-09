//
//  HeaderedView.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 09.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct HeaderedView<Header: View, Content: View>: View {
    
    var header: () -> Header
    var content: () -> Content
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header().frame(height: 100).padding(.top, SafeAreaInsets.top > 20 ? 20 : 0)
            content().edgesIgnoringSafeArea(.top)
        }.padding(.top, 0).withoutBar().edgesIgnoringSafeArea(.vertical)
    }
}

struct HeaderedView_Previews: PreviewProvider, HeaderedScreen {
    static var previews: some View {
        NavigationView {
            HeaderedView(header: {
                HeaderedView_Previews().header([Text("Some").font(.ultraLight(48)).foregroundColor(.hOrange)]
                )
            }, content: {
                Rectangle().foregroundColor(.green)
            })
        }
    }
}
