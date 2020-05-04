//
//  NewFaceDetection.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 04.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct NewFaceDetection: View, AuthAppScreens {
    @Environment(\.presentationMode) var presentation
    
    @State private var maskOpacity: CGFloat = 0.5
    @State private var selectedMaskCollection: Int?
    @State private var selectedMask: Int?
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                ARFaceDetectorView()
                    .edgesIgnoringSafeArea(.top)
                    .overlay(slider, alignment: .bottom)
                    .overlay(HStack(alignment: .bottom, spacing: 20) {
                        ForEach(0..<3, id: \.self) { i in
                            ScrollView {
                                VStack {
                                    ForEach(1..<4, id: \.self) { i in
                                        Image("\(i)")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 90, height: 90)
                                            .onTapGesture {
                                                self.selectedMask = i
                                                self.selectedMaskCollection = nil
                                            }
                                    }.rotationEffect(.radians(.pi), anchor: .center)
                                }
                            }.rotationEffect(.radians(.pi), anchor: .center)
                            .opacity(i == self.selectedMaskCollection ? 1 : 0)
                        }
                    }, alignment: .bottom)
                
                ZStack {
                    Color.black
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Button(action: {}) {
                                Image("backArrow")
                                    .foregroundColor(.white)
                                    .opacity(0.2)
                            }.disabled(true)
                            
                            ForEach(1..<4, id: \.self) { i in
                                Image("\(i)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .shadow(color: .white, radius: 30, x: 0, y: 4)
                                    .onTapGesture {
                                        self.selectedMaskCollection = i - 1
                                    }
                            }
                            
                            Button(action: {}) {
                                Image("backArrow")
                                    .rotationEffect(.radians(.pi), anchor: .center)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 11) {
                            borderedButton(action: {}, title: "Reset")
                            borderedButton(action: {}, title: "Done")
                        }.padding(.horizontal, 32)
                        .padding(.bottom)
                    }
                }.aspectRatio(414 / 239, contentMode: .fit)
            }
            
            onBackButton(presentation)
        }
    }
    
    var slider: some View {
        MaskSlider(value: $maskOpacity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
                .fill(Color.white)
                .frame(height: 44))
            .padding(.horizontal)
                .opacity(0.5)
    }
}

struct NewFaceDetection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewFaceDetection()
                .withoutBar()
        }
    }
}
