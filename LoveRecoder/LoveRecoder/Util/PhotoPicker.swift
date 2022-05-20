//
//  PhotoPicker.swift
//  collectionViewTest
//
//  Created by Blacour on 2021/10/21.
//

import Foundation
import UIKit

public protocol PhotoPickerGetImage: AnyObject {
    func getImage(image: UIImage)
}

class PhotoPicker: NSObject {
    var currentVC: UIViewController?
    weak var photoPickerDelegate: PhotoPickerGetImage?
}

extension PhotoPicker: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func goCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            currentVC?.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
        }
    }
    
    func goImage(){
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = false
        photoPicker.sourceType = .photoLibrary
        photoPicker.navigationBar.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        photoPicker.modalPresentationStyle = .fullScreen
        //在需要的地方present出来
        currentVC?.present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        //显示设置的照片
        photoPickerDelegate?.getImage(image: image)
        
        currentVC?.dismiss(animated: true, completion: nil)
    }

    
}
