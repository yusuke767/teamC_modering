//
//  HP.swift
//  teamC
//
//  Created by Hirotake Tomiyama on 2017/12/14.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

let stand_sleep_time: Float = 7.5 //目安となる睡眠時間(7時間30分)
var sleep_time: Float = 5         //睡眠時間
var hit_point: Float = 100        //HP
var per_time: Float = 0
let n: Float = 1                  //HPの減り方を見て調節



class CharacterHP {
    func HP(sleep: Float){
        per_time = sleep_time / stand_sleep_time
        
        if per_time < 1 {
            per_time = per_time - 1
            hit_point = hit_point - (per_time * n)
        } else if per_time > 1 {
            per_time = 1 - per_time
            hit_point = hit_point - (per_time * n)
        }
        
    }
    
}
