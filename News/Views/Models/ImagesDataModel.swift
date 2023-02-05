//
//  DataSave.swift
//  News
//
//  Created by Sonata Girl on 05.02.2023.
//

import UIKit

class ImagesDataModel {
    
    func loadImage(fileName: String) -> UIImage? {
//         if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
//             let imageUrl = documentsDirectory.appendingPathComponent(fileName)
//             let image = UIImage(contentsOfFile: imageUrl.path)
//             return nil
//         }
//         return nil
        
        return UIImage(named: fileName) ?? UIImage()
     }
}
