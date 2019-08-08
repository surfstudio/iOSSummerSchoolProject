//
//  FeedTestCell.swift
//  iOSSummerExampleProject
//
//  Created by xcode on 08.08.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

class FeedTestCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!

    var index: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        testLabel.text = "My index: \(index)"
    }

}
