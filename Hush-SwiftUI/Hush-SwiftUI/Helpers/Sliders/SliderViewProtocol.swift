//
//  SliderViewProtocol.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 08.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

protocol SliderViewProtocol where Self: View {}
extension SliderViewProtocol {
    var knobSide: CGFloat { 28 }
    var knob: some View {
        Circle()
            .fill(Color.white)
            .border(Color.black.opacity(0.04), width: 0.5)
            .frame(width: knobSide, height: knobSide)
            .shadow(color: Color(UIColor.black.withAlphaComponent(0.15)), radius: 8, x: 0, y: 3)
            .shadow(color: Color(UIColor.black.withAlphaComponent(0.16)), radius: 1, x: 0, y: 1)
            .shadow(color: Color(UIColor.black.withAlphaComponent(0.1)), radius: 1, x: 0, y: 3)
    }
}
