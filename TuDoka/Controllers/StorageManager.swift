//
//  StorageManager.swift
//  TuDoka
//
//  Created by Rafael Montoya on 8/1/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class StorageManager{
    static let dbInstance = StorageManager()
    
    private init(){
        
    }
    func subirFoto(idUsuario:String, idReporte:String, imagen: UIImage, completion: @escaping (Bool, String?)-> Void ){
        // Create a root reference
        let storage = Storage.storage()
        // Create a root reference
        let storageRef = storage.reference()
        
        let nombreArchivo = String(NSDate().timeIntervalSince1970)
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("reportes/"+idUsuario+"/"+idReporte+"/"+nombreArchivo+".jpg")
        
        if let uploadData = (imagen).pngData(){
            riversRef.putData(uploadData, metadata: nil, completion:
                {
                    (metadata, error) in
                    if error != nil{
                        print(error!)
                        completion(false, nil)
                    }
                    
                    riversRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            // Uh-oh, an error occurred!
                            return
                        }
                        print(downloadURL)
    
                        completion(true, downloadURL.absoluteString)
                        
                    }
            })
        }
        
    }
    
    func resize(_ image: UIImage) -> UIImage {
        var actualHeight = Float(image.size.height)
        var actualWidth = Float(image.size.width)
        let maxHeight: Float = 561.0
        let maxWidth: Float = 998.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 1.0
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!) ?? UIImage()
    }
}
