//
//  DetailMarketHeaderCell.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/28.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

class DetailMarketHeaderCell: UICollectionViewCell {

    @IBOutlet weak var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLable.textColor = XCFColor(102, g: 102, b: 102)
    }

}
