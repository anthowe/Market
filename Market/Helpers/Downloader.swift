//
//  Downloader.swift
//  Market
//
//  Created by Anthony Howe on 3/21/20.
//  Copyright © 2020 Anthony Howe. All rights reserved.
//

import Foundation
import FirebaseStorage

let storageDownloader = Storage.storage()

func uploadImages(images: [UIImage?], itemID: String,
                  completion: @escaping(_ imageLinks: [String]) -> Void){
    if Reachabilty.HasConnection(){
        
        var uploadedImagesAmount = 0
        var imageLinkArray: [String] = []
        var nameSuffix = 0
        
        for image in images {
            let fileName = "ItemImages/" + itemID + "/" + "\(nameSuffix)" + ".jpg"
            let imageData = image!.jpegData(compressionQuality: 0.5)
            
            saveImageToFirebase(imageData: imageData!, fileName: fileName) { (imageLink) in
                
                if imageLink != nil {
                    imageLinkArray.append(imageLink!)
                    uploadedImagesAmount += 1
                    
                    if uploadedImagesAmount == images.count{
                        completion(imageLinkArray)
                    }
                }
            }
            nameSuffix += 1
        }
    }
        else{
        print("No internet connection")
    }
    
}
func saveImageToFirebase(imageData: Data, fileName: String, completetion: @escaping(
    _ imageLink: String?)-> Void){
    
    var task: StorageUploadTask!
    let storageRef = storage.reference(forURL: kFILEREFERENCE).child(fileName)
    task = storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
        task.removeAllObservers()
        if error != nil{
            print("Error uploading image", error?.localizedDescription)
            completetion(nil)
            return
        }
        storageRef.downloadURL { (url, error) in
            guard let downloadURL = url else{
                completetion(nil)
                return
            }
            completetion(downloadURL.absoluteString)
        }
    })
}
