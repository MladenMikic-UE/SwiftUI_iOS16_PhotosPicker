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
    @Published var selectedImages: [UIImage]
    @Published var lastSelectionError: Error? = nil
    /// Setting the maxSelectionCount to 1 will set single selection.
    let maxSelectionCount: Int?
    let filter: PHPickerFilter
    
    private var bag = Set<AnyCancellable>()
    
    // MARK: - Init.
    
    public init(maxSelectionCount: Int?,
                filter: PHPickerFilter) {
        self.selectedItems = []
        self.tmpSelectedItems = []
        self.selectedImages = []
        self.maxSelectionCount = maxSelectionCount
        self.filter = filter
        
        self.$tmpSelectedItems
            .receive(on: RunLoop.main)
            .sink { newSelectedItems in
                
                guard !newSelectedItems.isEmpty else { return }
                
                if !self.selectedItems.isEmpty {
                    // Reselection will trigger cleanup
                    self.selectedItems = []
                    self.lastSelectionError = nil
                    self.selectedImages = []
                }
                
                self.tmpSelectedItems = []         
                
                self.selectedItems = newSelectedItems
            }
            .store(in: &self.bag)
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: WrapImage.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let wrapImage?):
                    self.selectedImages.append(wrapImage.image)
                case .success(nil):
                    self.lastSelectionError = TransferError.loadFailed
                case .failure(let error):
                    self.lastSelectionError = error
                }
            }
        }
    }
}

enum TransferError: Error {
    case importFailed
    case loadFailed
}

struct WrapImage: Transferable {
    let image: UIImage
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            return WrapImage(image: uiImage)
        }
    }
}
