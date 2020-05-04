//
//  NewFaceDetection.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 04.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct NewFaceDetection<ViewModel: NewFaceDetectionViewModeled>: View, AuthAppScreens {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                ARFaceDetectorView(maskImage: viewModel.maskImage)
                    .edgesIgnoringSafeArea(.top)
                    .overlay(slider, alignment: .bottom)
                    .overlay(HStack(alignment: .bottom, spacing: 20) {
                        ForEach(0..<3, id: \.self) { i in
                            ScrollView {
                                VStack {
                                    ForEach(1..<4, id: \.self) { i in
                                        MaskImage(name: i.description)
                                            .onTapGesture {
                                            }
                                    }.rotationEffect(.radians(.pi), anchor: .center)
                                }
                            }.rotationEffect(.radians(.pi), anchor: .center)
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

                            ForEach(viewModel.maskCategoriesImages[0].indices, id: \.self) { i in
                                MaskImage(name: self.viewModel.maskCategoriesImages[0][i])
                                    .shadow(color: .white, radius: 30, x: 0, y: 4)
                                    .onTapGesture {
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
        }
    }
    
    var slider: some View {
        MaskSlider(value: $viewModel.maskOpacity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
                .fill(Color.white)
                .frame(height: 44))
            .padding(.horizontal)
                .opacity(0.5)
    }
}

struct MaskImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 90, height: 90)
    }
}

struct NewFaceDetection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewFaceDetection(viewModel: NewFaceDetectionViewModel())
                .withoutBar()
        }
    }
}
