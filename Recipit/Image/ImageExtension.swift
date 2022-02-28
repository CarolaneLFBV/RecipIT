//
//  ImageExtension.swift
//  Recipit
//
//  Created by Carolane on 21/02/2022.
//

import SwiftUI

// Func to get every UIImage
func getImages(imageNames: [String]) -> [UIImage?] {
    var savedImages: [UIImage?] = [UIImage]()
    for imageName in imageNames {
        if let imagePath = getFilePath(fileName: imageName) {
            savedImages.append(UIImage(contentsOfFile: imagePath))
        }
    }
    return savedImages
}

// Func to save one UIImage
func saveImage(image: UIImage) -> String {
    let imageData = NSData(data: image.jpegData(compressionQuality: 0.8)!)
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true)
    let docs = paths[0] as NSString
    let uuid = NSUUID().uuidString + ".jpeg"
    let fullPath = docs.appendingPathComponent(uuid)
    _ = imageData.write(toFile: fullPath, atomically: true)
    return uuid
}

// Func to get File Path
func getFilePath(fileName: String) -> String? {
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    var filePath: String?
    let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
    if paths.count > 0 {
        let dirPath = paths[0] as NSString
        filePath = dirPath.appendingPathComponent(fileName)
    } else {
        filePath = nil
    }
    return filePath
}

