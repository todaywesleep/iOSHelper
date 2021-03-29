//
//  ImagePickerRepresentable.swift
//  Mockup
//
//  Created by Vladislav Erchik on 8.12.20.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        uiViewController.delegate = delegate
    }
}
