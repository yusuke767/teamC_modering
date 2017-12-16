//
//  CalendarCell.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/17.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    public var textLabel:UILabel!
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)!
        /*
        // UILabelを生成
        textLabel = UILabel()
        textLabel.frame = CGRect(x:0, y:0, width:self.frame.width, height:self.frame.height)
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textLabel.textAlignment = NSTextAlignment.center
        // Cellに追加
        self.addSubview(textLabel!)
 */
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        //UILabelを生成
        textLabel = UILabel()
        textLabel.frame = CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)
        textLabel.textAlignment = .center
        self.contentView.addSubview(textLabel!)
        
    }
}
