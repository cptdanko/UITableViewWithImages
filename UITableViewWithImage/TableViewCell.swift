//
//  TableViewCell.swift
//  UITableViewWithImage
//
//  Created by Bhuman Soni on 30/9/18.
//  Copyright © 2018 Bhuman Soni. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var rowLabel: UILabel!
    @IBOutlet var rowImage: UIImageView!

    var rowData: TableData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
