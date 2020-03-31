//
//  HSegmentedControl.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct HSegmentedControl: View {
    
    @Binding var selected: Int
    var list: [String] = []
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<list.count) { index in
                self.borderedButton(index)
            }
        }
    }
    
    func borderedButton(_ index: Int) -> some View {
       
        let title = list[index]
        let isSelected = index == selected
        
        return HapticButton(action: {
            self.selected = index
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(isSelected ? Color.clear : Color.white, lineWidth: 1)
                    .foregroundColor(.clear)
                    .background(isSelected ? Color.hOrange : Color.clear)
                    .frame(minHeight: 40, maxHeight: 48).cornerRadius(6)
                Text(title).padding(4).minimumScaleFactor(0.3).lineLimit(1).font(.light()).foregroundColor(isSelected ? .black : .white)
            }
        }
    }
}

struct HSegmentedControl_Previews: PreviewProvider {
    
    @State static var selected = 1
    
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HSegmentedControl(selected: $selected, list: ["1", "2", "3", "4"])
        }
    }
}
