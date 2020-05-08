//
//  UISliderView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 08.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct UISliderView: UIViewRepresentable {
    private let lower: Binding<Float>
    private let upper: Binding<Float>
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        return slider
    }
    
    func updateUIView(_ slider: UISlider, context: Context) {
        
    }
}

struct CustomSlider: View {
    private let knobSide: CGFloat = 28
    
    let minimumValue: Float = 0
    let maximumValue: Float = 1
    
    @State private var lowerTranslation: CGSize = .zero
    @State private var upperTranslation: CGSize = .zero
    
    @State private var size: CGSize = .zero
    
    @State private var lowerProgress: Float = 0
    @State private var upperProgress: Float = 1
    
    @State private var lowerSavedProgress: Float = 0
    @State private var upperSavedProgress: Float = 0
    
    @GestureState private var lowerMoved = false
    @GestureState private var upperMoved = false
    
    private var lowerKnobOffset: CGFloat {
        (size.width - knobSide * 2) * CGFloat(lowerProgress)
    }
    
    private var upperKnobOffset: CGFloat {
        (size.width - 2 * knobSide) * CGFloat(upperProgress) - size.width + 2 * knobSide
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(lowerProgress.description)
                Text(upperProgress.description)
            }
            
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
                        .zIndex(lowerMoved ? 1 : 0)
                    Spacer()
                    knob.offset(x: upperKnobOffset, y: 0)
                        .gesture(upperDrag)
                        .zIndex(upperMoved ? 1 : 0)
                }
            }.observeSize($size)
        }
    }
    
    var lowerDrag: some Gesture {
        DragGesture().onChanged { value in
            self.lowerTranslation = value.translation
            self.updateLowerProgress()
        }.onEnded { value in
            self.lowerSavedProgress = self.lowerProgress
        }.updating($lowerMoved) { _, state, _ in
            state = true
        }
    }
    
    var upperDrag: some Gesture {
        DragGesture().onChanged { value in
            self.upperTranslation = value.translation
            self.updateUpperProgress()
        }.onEnded { value in
            self.upperSavedProgress = 1 - self.upperProgress
        }.updating($upperMoved) { _, state, _ in
            state = true
        }
    }
    
    func updateLowerProgress() {
        let progress = Float((lowerTranslation.width) / (size.width - 2 * knobSide))
        lowerProgress = min(max(progress + lowerSavedProgress, minimumValue), upperProgress)//maximumValue)
    }
    
    func updateUpperProgress() {
        let progress = Float((upperTranslation.width + size.width - 2 * knobSide) / (size.width - 2 * knobSide))
        upperProgress = min(max(progress - upperSavedProgress, lowerProgress), maximumValue)
    }
    
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


struct UISliderView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
