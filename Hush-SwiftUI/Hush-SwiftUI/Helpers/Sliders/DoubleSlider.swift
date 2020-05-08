//
//  DoubleSlider.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 08.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct DoubleSlider: View, SliderViewProtocol {
    @Binding var lower: Double
    @Binding var upper: Double
    
    private let minimumValue: Double = 0
    private let maximumValue: Double = 1
    
    @State private var lowerSavedProgress: Double = 0
    @State private var upperSavedProgress: Double = 0
    
    @State private var lowerTranslation: CGSize = .zero
    @State private var upperTranslation: CGSize = .zero
    
    @State private var size: CGSize = .zero
    
    var body: some View {
        ZStack {
            Rectangle().frame(height: 3)
                .foregroundColor(Color(0x787880).opacity(0.2))
            Rectangle().frame(height: 3)
                .foregroundColor(Color.hOrange)
                .padding(.leading, lowerKnobOffset)
                .padding(.trailing, -upperKnobOffset)
            HStack {
                knob.offset(x: lowerKnobOffset, y: 0)
                    .gesture(lowerDrag)
                Spacer()
                knob.offset(x: upperKnobOffset, y: 0)
                    .gesture(upperDrag)
            }
        }.observeSize($size)
    }
}

private extension DoubleSlider {
    var lowerDrag: some Gesture {
        DragGesture().onChanged { value in
            self.lowerTranslation = value.translation
            self.updateLowerProgress()
        }.onEnded { value in
            self.lowerSavedProgress = self.lower
        }
    }
    
    var upperDrag: some Gesture {
        DragGesture().onChanged { value in
            self.upperTranslation = value.translation
            self.updateUpperProgress()
        }.onEnded { value in
            self.upperSavedProgress = 1 - self.upper
        }
    }
    
    var lowerKnobOffset: CGFloat {
        (size.width - knobSide * 2) * CGFloat(lower)
    }
    
    var upperKnobOffset: CGFloat {
        (size.width - 2 * knobSide) * CGFloat(upper) - size.width + 2 * knobSide
    }
    
    func updateLowerProgress() {
        let progress = (lowerTranslation.width) / (size.width - 2 * knobSide)
        lower = min(max(Double(progress) + lowerSavedProgress, minimumValue), upper)//maximumValue)
    }
    
    func updateUpperProgress() {
        let progress = (upperTranslation.width + size.width - 2 * knobSide) / (size.width - 2 * knobSide)
        upper = min(max(Double(progress) - upperSavedProgress, lower), maximumValue)
    }
}

struct UISliderView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleSlider(lower: .constant(0.2), upper: .constant(0.6))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
