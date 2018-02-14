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
        
        let stand_sleep_time: Float = 27000 //目安となる睡眠時間(7時間30分)
        var hit_point: Float = 0            //体力
        var exp_point: Int = 0            //好感度
        
        //ファイルパス
        let documentsPath = NSHomeDirectory() + "/Documents"
        let file_path_HP = documentsPath + "/体力.txt"
        let file_path_EXP = documentsPath + "/好感度.txt"
        let file_path_suimin = documentsPath + "/睡眠時間.txt"
        
        do {
            //体力読み込み
            let tairyoku = try String( contentsOfFile: file_path_HP, encoding: String.Encoding.utf8 )
            hit_point = Float(tairyoku)!
            //好感度読み込み
            let koukando = try String( contentsOfFile: file_path_EXP, encoding: String.Encoding.utf8 )
            exp_point = Int(Float(koukando)!)
            //睡眠時間読み込み
            //let file_path_suimin = "/Users/e155748/Desktop/teamC_modering/teamC/TXT/睡眠時間.txt"
            let text = try String( contentsOfFile: file_path_suimin, encoding: String.Encoding.utf8 )
            let suimin = text.components(separatedBy: " ")
            print("suimin:\(suimin)")
            
            //時
            var suimin_hour: Int = Int(suimin[3])!
            //print("suimin:\(suimin_hour)")
            suimin_hour = suimin_hour*60*60
            //分
            var suimin_minute: Int = Int(suimin[4])!
            //print("suimin:\(suimin_minute)")
            suimin_minute = suimin_minute*60
            //秒
            let suimin_second: Int = Int(suimin[5])!
            //print("suimin:\(suimin_second)")
            //睡眠時間合計・秒
            let suimin_all = suimin_hour+suimin_minute+suimin_second
            let sleep_time_float = Float(suimin_all)
            
            //体力が0以下ならリセット
            if hit_point <= 0 {
                hit_point = 100
                exp_point = 0
            } else {
                var per_time = sleep_time_float / stand_sleep_time
                if per_time < 1 {
                    //睡眠時間が基準より少ないとHPを減らす
                    per_time = 1 - per_time
                    hit_point = hit_point - (per_time * 100)
                    //print("hit_point")
                    //print(hit_point)
                } else if per_time >= 1 {
                    //睡眠時間が基準より多ければ好感度を増やす
                    exp_point = exp_point + 1
                }
            }
            
            //型変換
            let hit_point_str : String = String(hit_point)
            let exp_point_str : String = String(exp_point)
            //体力、好感度をテキストファイルに書き込む.
            try hit_point_str.write(toFile: file_path_HP, atomically: true, encoding: String.Encoding.utf8)
            try exp_point_str.write(toFile: file_path_EXP, atomically: true, encoding: String.Encoding.utf8)
            /*
            //----------テスト用
            let path_HP = "/Users/e155748/Desktop/teamC_modering/teamC/TXT/体力.txt"
            try hit_point_str.write(toFile: path_HP, atomically: true, encoding: String.Encoding.utf8)
            let path_EXP = "/Users/e155748/Desktop/teamC_modering/teamC/TXT/好感度.txt"
            try exp_point_str.write(toFile: path_EXP, atomically: true, encoding: String.Encoding.utf8)
            //----------
            */
        } catch {
            print("Characterエラー")
        }
        
    }
}
