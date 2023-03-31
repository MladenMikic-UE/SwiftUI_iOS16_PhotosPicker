//
//  ContentView.swift
//  SwiftUI_iOS16_PhotosPicker
//
//  Created by Mladen Mikić on 29.03.2023.
//

import SwiftUI
import PhotosUI


struct MainView: View {
    
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
