//
//  CharacterHP.swift
//  teamC
//
//  Created by Hirotake Tomiyama on 2017/12/14.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

class CharacterHP {
    func CharaHP(){
        
        let sleep_time: Float = 1         //睡眠時間
        let stand_sleep_time: Float = 7.5 //目安となる睡眠時間(7時間30分)
        var hit_point: Float = 0          //体力
        var exp_point: Float = 0          //好感度
        var per_time: Float = 0
        //ファイルパス
        let documentsPath = NSHomeDirectory() + "/Documents"
        let file_path = documentsPath + "/体力.txt"
        let file_path_2 = documentsPath + "/好感度.txt"
        
        do {
            //体力読み込み
            let tairyoku = try String( contentsOfFile: file_path, encoding: String.Encoding.utf8 )
            hit_point = Float(tairyoku)!
            //好感度読み込み
            let koukando = try String( contentsOfFile: file_path_2, encoding: String.Encoding.utf8 )
            exp_point = Float(koukando)!
            
            //体力が0以下ならリセット
            if hit_point <= 0 {
                hit_point = 100
                exp_point = 0
            } else {
                per_time = sleep_time / stand_sleep_time
                
                if per_time < 1 {
                    //睡眠時間が基準より少ないとHPを減らす
                    per_time = 1 - per_time
                    hit_point = hit_point - (per_time * 100)
                    //print("xxx")
                } else if per_time >= 1 {
                    //睡眠時間が基準より多ければ好感度を増やす
                    exp_point = exp_point + 1
                    //print("vvv")
                }
                
            }
            
            //体力をテキストファイルに書き込む.
            let hit_point_str : String = String(hit_point)
            let exp_point_str : String = String(exp_point)
            
            
            
            
            try hit_point_str.write(toFile: file_path, atomically: true, encoding: String.Encoding.utf8)
            //print(hit_point_str)

            try exp_point_str.write(toFile: file_path_2, atomically: true, encoding: String.Encoding.utf8)
            //print(exp_point_str)
            
        } catch {
            print("エラー")
        }
        
    }
}

