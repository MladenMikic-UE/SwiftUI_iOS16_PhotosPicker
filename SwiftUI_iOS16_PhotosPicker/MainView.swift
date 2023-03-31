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
                        .resizable()
                        .frame(width: 54, height: 54)
                )
            }
            .onTapGesture {
                print("TapGesture-1")
            }
            
            Spacer().frame(height: 24)
            
            PhotosPickerContainerView(viewModel: vm.videosPVM) {
                AnyView(
                    Image(systemName: "video.fill")
                        .resizable()
                        .frame(width: 54, height: 44)
                    /*
                    // Works but does not make sense with allowsHitTesting.
                    // Buttons cant be used.
                    Button(action: {
                        let _ = print("Button2")
                    }, label: {
                        Text("Button2")
                    })
                    .allowsHitTesting(false)
                    */
                )
            }
            
            Spacer().frame(height: 24)
            
            Button {
                let _ = print("imagesPVM.selectedItems.count: \(self.vm.imagesPVM.selectedItems.count)")
            } label: {
                Text("Log Selections")
            }

        }
    }
    

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
