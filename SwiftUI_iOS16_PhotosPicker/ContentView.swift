//
//  ContentView.swift
//  SwiftUI_iOS16_PhotosPicker
//
//  Created by Mladen Mikić on 29.03.2023.
//

import SwiftUI
import PhotosUI


struct ContentView: View {
    
    @StateObject var vm: PhotosManagerViewModel = .init()
    
        var body: some View {
        
        VStack {
            
            PhotosPickerContainerView(viewModel: vm.imagesPVM) {
                AnyView(
                    Image(systemName: "photo.on.rectangle.angled")
                )
            }
            
            PhotosPickerContainerView(viewModel: vm.videosPVM) {
                AnyView(
                    Button(action: {
                        let _ = print("Button2")
                    }, label: {
                        Text("Button2")
                    })
                    .allowsHitTesting(false)
                )
            }

        }
    }
    

}



struct PhotosPickerContainerView: View {
    
    @ObservedObject var viewModel: PhotosViewModel
    // A Button can not be used. The touch is not passed to the PhotosPicker.
    // Using .allowsHitTesting(false) on the button does not make much sense but it works.
    var photosButtonView: () -> AnyView
    
    var body: some View {
        
        PhotosPicker(selection: $viewModel.selectedItems,
                     maxSelectionCount: viewModel.maxSelectionCount,
                     matching: viewModel.filter, label: { photosButtonView() })
        
    }
}


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

final class PhotosManagerViewModel: ObservableObject {
    
    @Published var imagesPVM: PhotosViewModel
    @Published var videosPVM: PhotosViewModel
    
    init() {
        self.imagesPVM = .init(maxSelectionCount: nil, filter: .images)
        self.videosPVM = .init(maxSelectionCount: 1, filter: .videos)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
