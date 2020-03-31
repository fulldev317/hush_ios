//
//  AddPhotosView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct AddPhotosView: View {

    // MARK: - Properties
    
    @ObservedObject var viewModel =  AddPhotosViewModel()
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        Text(viewModel.message).onTapGesture(perform: viewModel.updateMessage)
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotosView()
    }
}
