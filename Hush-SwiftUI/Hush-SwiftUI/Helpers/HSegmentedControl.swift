//
//  HSegmentedControl.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct HSegmentedControl: View {
    
    private var selected: Binding<Int>?
    private var selectedList: Binding<Set<Int>>?
    private var list: [String] = []
    
    init(selected: Binding<Int>, list: [String]) {
        self.selected = selected
        self.list = list
    }
    
    init(selectedList: Binding<Set<Int>>, list: [String]) {
        self.selectedList = selectedList
        self.list = list
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<list.count) { index in
                self.borderedButton(index)
            }
        }
    }
    
    private func isIndexSelected(_ index: Int) -> Bool {
        if let selected = selected {
            return selected.wrappedValue == index
        } else if let selectedList = selectedList {
            return selectedList.wrappedValue.contains(index)
        } else {
            fatalError()
        }
    }
    
    func borderedButton(_ index: Int) -> some View {
       
        let title = list[index]
        let isSelected = isIndexSelected(index)
        
        return HapticButton(action: {
            self.selected?.wrappedValue = index
            
            guard let selectedList = self.selectedList else { return }
            if selectedList.wrappedValue.contains(index) {
                selectedList.wrappedValue.remove(index)
            } else {
                selectedList.wrappedValue.insert(index)
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(isSelected ? Color.clear : Color.white, lineWidth: 1)
                    .foregroundColor(.clear)
                    .background(isSelected ? Color.hOrange : Color.clear)
                    .frame(minHeight: 36, maxHeight: 38).cornerRadius(6)
                Text(title)
                    .kerning(1)
                    .padding(2)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .font(.light())
                    .foregroundColor(isSelected ? .black : .white)
            }
        }
    }
}

struct HSegmentedControl_Previews: PreviewProvider {
    
    @State static var selected = 1
    
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HSegmentedControl(selected: $selected, list: ["Male", "Female", "Couple", "Gay"])
        }
    }
}
