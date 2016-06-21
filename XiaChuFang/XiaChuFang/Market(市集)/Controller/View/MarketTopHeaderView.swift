//
//  MarketTopHeaderView.swift
//  XiaChuFang
//
//  Created by 罗金 on 16/6/7.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

import UIKit

protocol MarketTopHeaderViewDelegate: class {
    func marketTopHeaderViewAreaBtnAction()
    func marketTopHeaderViewClassicalBtnsAction(sender :UIButton)
}

class MarketTopHeaderView: UICollectionReusableView {
    
    var delegate : MarketTopHeaderViewDelegate?

    @IBAction func areaBtnAction(sender: UIButton) {
        if let _delegate = delegate {
            _delegate.marketTopHeaderViewAreaBtnAction()
        }
    }
    
    
    @IBAction func classicalBtnsAction(sender: UIButton) {
        if let _delegate = delegate {
            _delegate.marketTopHeaderViewClassicalBtnsAction(sender)
        }
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
