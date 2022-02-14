//
//  MediaPicker.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/29/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import PhotosUI

struct MediaPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    let filter: PHPickerFilter
    var limit: Int = 0
    let onCompletion: ([PHPickerResult]) -> Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = filter
        config.selectionLimit = limit
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    static func convertToUIImageArray(fromResults results: [PHPickerResult], onComplete: @escaping ([UIImage]?, Error?) -> Void) {
        var images = [UIImage]()
        let dispatchGroup = DispatchGroup()
        for result in results {
            dispatchGroup.enter()
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (imageOrNil, errorOrNil) in
                    if let error = errorOrNil {
                        onComplete(nil, error)
                    }
                    if let image = imageOrNil as? UIImage {
                        images.append(image)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            onComplete(images, nil)
        }
    }
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: MediaPicker
        init(_ parent: MediaPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true) { [weak self] in
                self?.parent.onCompletion(results)
            }
        }
    }
}

struct MediaPicker_Previews: PreviewProvider {
    static var previews: some View {
        MediaPicker(filter: .images, limit: 6 ){ _ in
            
        }
    }
}
