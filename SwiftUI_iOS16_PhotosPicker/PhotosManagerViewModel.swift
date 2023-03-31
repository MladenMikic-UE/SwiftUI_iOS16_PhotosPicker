//
//  PhotosManagerViewModel.swift
//  SwiftUI_iOS16_PhotosPicker
//
//  Created by Mladen Mikić on 31.03.2023.
//

import Foundation
import Combine


final class PhotosManagerViewModel: ObservableObject {
    
    @Published var imagesPVM: PhotosViewModel
    @Published var videosPVM: PhotosViewModel
    
    private var bag = Set<AnyCancellable>()
    
    // MARK: - Init.
    
    init() {
        self.imagesPVM = .init(maxSelectionCount: nil, filter: .images)
        self.videosPVM = .init(maxSelectionCount: 1, filter: .videos)
    }
    
    private func setupPublishers() {
        
        self.$imagesPVM
            .receive(on: RunLoop.main)
            .sink { _ in
                print("imagesPVM changed")
            }
            .store(in: &self.bag)
        
        self.$videosPVM
            .receive(on: RunLoop.main)
            .sink { _ in
                print("imagesPVM changed")
            }
            .store(in: &self.bag)
        
        self.imagesPVM.$selectedItems
            .receive(on: RunLoop.main)
            .sink { newSelectedItems in
                print("New images have been selected: \(newSelectedItems)")
            }
            .store(in: &self.bag)
                
        self.videosPVM.$selectedItems
            .receive(on: RunLoop.main)
            .sink { newSelectedItems in
                print("New videos have been selected: \(newSelectedItems)")
            }
            .store(in: &self.bag)
    }
}
