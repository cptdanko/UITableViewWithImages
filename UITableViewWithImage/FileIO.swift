import Foundation
import UIKit

class FileIO {
    
    static let fileIO = FileIO()
    /*
     Why are some methods static in this class and why some aren't?
     This is so so confusing. One class and that too has such confusing stuff
     */
    static func getDocumentsDir(filePathName fpn: String) -> String {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let archiveUrl = documentsDirectory.appendingPathComponent("\(fpn)")
        return archiveUrl
    }
    
    static func saveFiles(files:[TableData], filePath: String) -> Bool {
        let saveSuccessful = NSKeyedArchiver.archiveRootObject(files, toFile: FileIO.getDocumentsDir(filePathName: filePath))
        if !saveSuccessful {
            return false
        }
        return true
    }
    func getNameWithDirPath(filename: String) -> String {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        return documentsDirectory.appendingPathComponent(filename)
    }
    func saveImage(saveFileName:String, image: UIImage) {
        let data = UIImageJPEGRepresentation(image, 1)
        FileManager.default.createFile(atPath: saveFileName, contents: data, attributes: nil)
    }
    static func getFileURL(fileName:String) -> URL? {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dirContents = try? FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
        if let dc = dirContents {
            return dc.first{$0.absoluteString.contains(fileName)}
        }
        return nil
    }
    static func getSavedFileObjects(filePath:String) -> [TableData]? {
        let name = FileIO.getDocumentsDir(filePathName: filePath)
        return NSKeyedUnarchiver.unarchiveObject(withFile: name) as? [TableData]
    }
    static func deleteImageFile(imagePathToDelete: String) -> Bool {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: imagePathToDelete)
            return true
        } catch _ {
            return false
        }
    }
}
