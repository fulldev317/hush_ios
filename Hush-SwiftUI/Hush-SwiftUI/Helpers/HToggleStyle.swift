//
//  HToggleStyle.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct HToggleStyle: ToggleStyle {
    
    var label = ""
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Text(label)
            Spacer()
            HapticButton(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 55, height: 32)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 12 : -13))
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

struct HToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("", isOn: .constant(false)).toggleStyle(HToggleStyle(onColor: Color(0x7ED321), offColor: Color(0xEB5757)))
        
    }
}
