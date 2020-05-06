//
//  MaskSlider.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 04.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

struct MaskSlider: UIViewRepresentable {
    @Binding var isEnabled: Bool
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.thumbTintColor = UIColor.black
        slider.tintColor = UIColor.black.withAlphaComponent(0.6)
        slider.maximumTrackTintColor = UIColor.black.withAlphaComponent(0.6)
        
        slider.maximumValueImage = UIImage(named: "maskEnabled")?.withTintColor(.black)
        slider.minimumValueImage = UIImage(named: "maskDisabled")?.withTintColor(.black)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ slider: UISlider, context: Context) {
        slider.value = isEnabled ? slider.maximumValue : slider.minimumValue
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($isEnabled)
    }
    
    class Coordinator {
        @Binding var isEnabled: Bool
        
        init(_ isEnabled: Binding<Bool>) {
            _isEnabled = isEnabled
        }
        
        @objc func sliderValueChanged(slider: UISlider, event: UIEvent) {
            guard event.allTouches?.first?.phase == .ended else { return }
            let roundedValue = slider.value.rounded()
            isEnabled = roundedValue > 0.5
            slider.value = roundedValue
        }
    }
}
