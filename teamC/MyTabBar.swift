//
//  MyTabBar.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/08.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = self.frame.height
        //print(self.frame.height)
        return size
    }

}
