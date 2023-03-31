//
//  PhotosViewModel.swift
//  SwiftUI_iOS16_PhotosPicker
//
//  Created by Mladen Mikić on 31.03.2023.
//

import SwiftUI
import PhotosUI


final class PhotosViewModel: ObservableObject {

    @Published var selectedItems: [PhotosPickerItem]
    /// Setting the maxSelectionCount to 1 will set single selection.
    let maxSelectionCount: Int?
    let filter: PHPickerFilter
    
    public init(maxSelectionCount: Int?,
                filter: PHPickerFilter) {
        self.selectedItems = []
        self.maxSelectionCount = maxSelectionCount
        self.filter = filter
    }
}
