//
//  SingleSlider.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 08.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SingleSlider: View, SliderViewProtocol {
    @Binding var value: Double
    @State private var savedValue: Double = 0
    @State private var translation: CGSize = .zero
    @State private var size: CGSize = .zero
    
    var body: some View {
        ZStack {
            Rectangle().frame(height: 3)
                .foregroundColor(Color(0x787880).opacity(0.2))
            Rectangle().frame(height: 3)
                .foregroundColor(Color.hOrange)
                .padding(.trailing, size.width - knobOffset)
            HStack {
                knob.offset(x: knobOffset, y: 0)
                    .gesture(knobDrag)
                Spacer()
            }
        }.observeSize($size)
    }
}

private extension SingleSlider {
    var knobDrag: some Gesture {
        DragGesture().onChanged { value in
            self.translation = value.translation
            self.updateProgress()
        }.onEnded { value in
            self.savedValue = self.value
        }
    }
    
    var knobOffset: CGFloat {
        (size.width - knobSide) * CGFloat(value)
    }
    
    func updateProgress() {
        let progress = (translation.width) / (size.width - knobSide)
        value = min(max(Double(progress) + savedValue, 0), 1)
    }
}

struct SingleSlider_Previews: PreviewProvider {
    static var previews: some View {
        SingleSlider(value: .constant(0.3))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
