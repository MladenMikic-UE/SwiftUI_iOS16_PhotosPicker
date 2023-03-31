//
//  PhotosViewModel.swift
//  SwiftUI_iOS16_PhotosPicker
//
//  Created by Mladen Mikić on 31.03.2023.
//

import SwiftUI
import PhotosUI
import Combine


final class PhotosViewModel: ObservableObject {

    /// Temporary selections allows for items to be selected and manipulated further before exposing the selection array.
    @Published var tmpSelectedItems: [PhotosPickerItem]
    @Published var selectedItems: [PhotosPickerItem]
    /// Setting the maxSelectionCount to 1 will set single selection.
    let maxSelectionCount: Int?
    let filter: PHPickerFilter
    
    private var bag = Set<AnyCancellable>()
    
    // MARK: - Init.
    
    public init(maxSelectionCount: Int?,
                filter: PHPickerFilter) {
        self.selectedItems = []
        self.tmpSelectedItems = []
        self.maxSelectionCount = maxSelectionCount
        self.filter = filter
        
        self.$tmpSelectedItems
            .receive(on: RunLoop.main)
            .sink { newSelectedItems in
                
                guard !newSelectedItems.isEmpty else { return }
                
                if !self.selectedItems.isEmpty {
                    // Reselection will trigger cleanup
                    self.selectedItems = []
                }
                
                self.tmpSelectedItems = []
                self.selectedItems = newSelectedItems
            }
            .store(in: &self.bag)
    }
}
