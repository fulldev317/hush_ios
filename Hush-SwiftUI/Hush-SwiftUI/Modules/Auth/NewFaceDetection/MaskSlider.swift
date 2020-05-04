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
        slider.isContinuous = false
        
        slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ slider: UISlider, context: Context) {
        slider.value = Float(value)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($value)
    }
    
    class Coordinator {
        @Binding var value: CGFloat
        init(_ value: Binding<CGFloat>) {
            _value = value
        }
        
        @objc func sliderValueChanged(slider: UISlider, event: UIEvent) {
            let value = slider.value
            if let touchEvent = event.allTouches?.first {
                switch touchEvent.phase {
                case .ended:
                    slider.value = value.rounded()
                    self.value = CGFloat(value.rounded())
                default:
                    break
                }
            }
        }
    }
}

struct MaskSlider_Previews: PreviewProvider {
    static var previews: some View {
        MaskSlider(value: .constant(0.5))
    }
}
