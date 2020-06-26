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
    @Binding var selectedValue: Double

    @State private var savedValue: Double
    @State private var translation: CGSize = .zero
    @State private var size: CGSize = .zero
    
    init(value outerValue: Binding<Double>, selectedValue endValue: Binding<Double>) {
        _value = outerValue
        _selectedValue = endValue
        _savedValue = State<Double>(initialValue: outerValue.wrappedValue)
    }
    
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
            self.selectedValue = self.value
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
    struct Content: View {
        @State var slider = 1.0
        @State var selectedValue = 1.0

        var body: some View {
            SingleSlider(value: $slider, selectedValue: $selectedValue)
                .padding()
        }
    }
    
    static var previews: some View {
        Content()
            .previewLayout(.sizeThatFits)
    }
}
