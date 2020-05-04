//
//  MaskSlider.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 04.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct MaskSlider: UIViewRepresentable {
    @Binding var value: CGFloat
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.thumbTintColor = UIColor.black
        slider.tintColor = UIColor.black.withAlphaComponent(0.6)
        slider.maximumTrackTintColor = UIColor.black.withAlphaComponent(0.6)
        
        slider.maximumValueImage = UIImage(named: "maskEnabled")?.withTintColor(.black)
        slider.minimumValueImage = UIImage(named: "maskDisabled")?.withTintColor(.black)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        return slider
    }
    
    func updateUIView(_ slider: UISlider, context: Context) {
        slider.value = Float(value)
    }
}

struct MaskSlider_Previews: PreviewProvider {
    static var previews: some View {
        MaskSlider(value: .constant(0.5))
    }
}
