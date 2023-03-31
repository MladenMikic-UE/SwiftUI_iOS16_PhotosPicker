//
//  PhotosPickerContainerView.swift
//  SwiftUI_iOS16_PhotosPicker
//
//  Created by Mladen Mikić on 31.03.2023.
//

import SwiftUI
import PhotosUI


struct PhotosPickerContainerView: View {
    
    @ObservedObject var viewModel: PhotosViewModel
    // A Button can not be used. The touch is not passed to the PhotosPicker.
    // Using .allowsHitTesting(false) on the button does not make much sense but it works.
    var photosButtonView: () -> AnyView
    
    var body: some View {
        
        PhotosPicker(selection: $viewModel.tmpSelectedItems,
                     maxSelectionCount: viewModel.maxSelectionCount,
                     matching: viewModel.filter, label: { photosButtonView() })
        .onAppear {
            // onAppear does not as expected and can not be used for state purposes.
            let _ = print("\n.onAppear PhotosPickerContainerView")
        }
        
    }
}
