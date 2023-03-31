//
//  PhotosManagerViewModel.swift
//  SwiftUI_iOS16_PhotosPicker
//
//  Created by Mladen Mikić on 31.03.2023.
//

import Foundation


final class PhotosManagerViewModel: ObservableObject {
    
    @Published var imagesPVM: PhotosViewModel
    @Published var videosPVM: PhotosViewModel
    
    init() {
        self.imagesPVM = .init(maxSelectionCount: nil, filter: .images)
        self.videosPVM = .init(maxSelectionCount: 1, filter: .videos)
    }
}
