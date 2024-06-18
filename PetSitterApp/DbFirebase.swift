//
//  DbFirebase.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/17/24.
//

import FirebaseStorage
import UIKit

class DbFirebase {
    func uploadImage(imageName: String, image: UIImage, completion: @escaping (Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let reference = Storage.storage().reference().child("petImages").child(imageName)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        reference.putData(imageData, metadata: metaData) { (_, error) in
            completion(error)
        }
    }
    
    func downloadImage(imageName: String, completion: @escaping (UIImage?) -> Void) {
        let reference = Storage.storage().reference().child("petImages").child(imageName)
        let megaByte = Int64(10 * 1024 * 1024)
        
        reference.getData(maxSize: megaByte) { data, error in
            completion(data != nil ? UIImage(data: data!) : nil)
        }
    }
}
