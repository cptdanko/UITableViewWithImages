//
//  DetailViewController.swift
//  UITableViewWithImage
//
//  Created by Bhuman Soni on 30/9/18.
//  Copyright © 2018 Bhuman Soni. All rights reserved.

import UIKit

class DetailViewController: UIViewController {
    
    var rowData: TableData?
    //MARK: IBOutlet
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var rowImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rd = rowData {
            nameLbl.text = rd.name
            rowImage.image = rd.getRowImage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
