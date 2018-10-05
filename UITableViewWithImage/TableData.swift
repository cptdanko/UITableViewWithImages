//
//  TableData.swift
//  UITableViewWithImage
//
//  Created by Bhuman Soni on 28/9/18.
//  Copyright © 2018 Bhuman Soni. All rights reserved.
//

import UIKit
import Foundation

class TableData: NSObject {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getRowThumbnail() -> UIImage {
        let thumbnailname = FileIO.fileIO.getNameWithDirPath(filename: "\(name)\(Constants.THUMBNAIL_NAME)\(Constants.ROW_DATA_IMG_EXTENSION)")
        let thumbnail = UIImage(contentsOfFile: thumbnailname)!
        return thumbnail
    }
    func getRowImage() -> UIImage {
        let imageName = FileIO.fileIO.getNameWithDirPath(filename: "\(name)\(Constants.ROW_DATA_IMG_EXTENSION)")
        let image = UIImage(contentsOfFile: imageName)!
        return image
    }
}
