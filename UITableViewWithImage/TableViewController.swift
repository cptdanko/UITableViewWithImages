//
//  TableViewController.swift
//  UITableViewWithImage
//
//  Created by Bhuman Soni on 28/9/18.
//  Copyright © 2018 Bhuman Soni. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var data = [TableData]()
    
    let imagePickerDelagate = UIImagePickerController()
    
    var selRowImg: UIImage?
    var selRowName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    @IBAction func capture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            fatalError("Cannot cast the memory cell")
        }
        let rowData = data[indexPath.row]
        cell.rowLabel.text = rowData.name
        cell.rowImage.image = rowData.getRowThumbnail()
        /* //replacing the row image with this code will make it slow
        cell.rowImage.image = rowData.getRowImage()
        */
        cell.rowData = rowData
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destViewController = segue.destination as? DetailViewController else {
            return
        }
        guard let senderCell = sender as? TableViewCell else {
            return
        }
        destViewController.rowData = senderCell.rowData
    }
    
    //MARK: ImagePicker delegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Error getting the image")
            return
        }
        //save two copies of the image
        let imageName = "Image_\(data.count)"
        
        //Step 1: save original image
        let fullImgFilename = FileIO.fileIO.getNameWithDirPath(filename: "\(imageName)\(Constants.ROW_DATA_IMG_EXTENSION)")
        FileIO.fileIO.saveImage(saveFileName: fullImgFilename, image: image)
        //Step 2: resize image
        let thumbnailImage = UIImage.resizeImage(image: image, targetSize: CGSize(width: 75, height: 75))
        //Step 3: save thumbnail
        let thumbnailname = FileIO.fileIO.getNameWithDirPath(filename: "\(imageName)\(Constants.THUMBNAIL_NAME)\(Constants.ROW_DATA_IMG_EXTENSION)")
        FileIO.fileIO.saveImage(saveFileName: thumbnailname, image: thumbnailImage)
        
        let newRow = TableData(name: imageName)
        data.append(newRow)
        tableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }

}

extension UIImage {
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if (widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
