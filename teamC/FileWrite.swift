
//
//  FileWrite.swift/Users/e165703/modering_c/modering_c/FileWrite.swift
//  modering_c
//
//  Created by 大城　拓千 on 2017/12/07.
//  Copyright © 2017年 大城　拓千. All rights reserved.
//

import Foundation
import UIKit
class Filewrite{
    @objc func slept_time(){
        let a = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let b = formatter.string(from: a as Date)
        let d: String = String(b)
        do {
            try d.write(toFile: "/Users/e165703/モデリングC/slept_time.txt", atomically: true, encoding: String.Encoding.utf8)
            /*//-----------テスト用
            let path_slept = "/Users/e155748/Desktop/teamC_modering/teamC/TXT/slept_time.txt"
            try d.write(toFile: path_slept, atomically: true, encoding: String.Encoding.utf8)
            //-----------*/
        } catch {
            print("aaa")
            // Failed to write file
        }
        
    }
    @objc func sleep_time(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Tokyo")! as TimeZone
        dateFormatter.locale = NSLocale(localeIdentifier: "ja") as Locale!
        dateFormatter.dateFormat = "HH:mm:ss"
        let sleep = NSDate()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let comps = calendar.components([.year, .month, .day, .hour, .minute, .second], from: sleep as Date)
        
        
        let sleep2 = formatter.string(from: sleep as Date)
        let sleep3: String = String(sleep2)
        print("sleep2\(sleep2)")
        do {
            let documentsPath_1 = NSHomeDirectory() + "/Documents"
            let file_path_1 = documentsPath_1 + "/slept_time.txt"
            let text = try String(contentsOfFile: file_path_1, encoding: String.Encoding.utf8)
            let get_up = sleep3.components(separatedBy: ":")
            var sleeptime = text.components(separatedBy: ":")
            sleeptime[2] = sleeptime[2].replacingOccurrences(of:"\n",with:"")
            print("sleeptime\(sleeptime)")
            
            
            var getup_hour: Int = Int(get_up[0])!
            getup_hour = 60*60*getup_hour
            
            var getup_minute: Int = Int(get_up[1])!
            getup_minute = 60*getup_minute
            var getup_second: Int = Int(get_up[2])!
            
            var getup_all = getup_hour+getup_second+getup_minute
            print("getup_all\(getup_all)")
            var sleeptime_hour: Int = Int(sleeptime[0])!
            var t: Int = Int(sleeptime[0])!
            sleeptime_hour = 60*60*sleeptime_hour
            if sleeptime_hour == 82800 || sleeptime_hour == 79200{
                sleeptime_hour = 0
            }
            var sleeptime_minute: Int = Int(sleeptime[1])!
            sleeptime_minute = 60*sleeptime_minute
            var sleeptime_second: Int = Int(sleeptime[2])!
            var sleeptime_all = sleeptime_hour+sleeptime_second+sleeptime_minute
            print("sleeptime_all\(sleeptime_all)")
            var suimin_second = getup_all-sleeptime_all
            if t == 23{
                suimin_second = suimin_second + 60*60*1
            }
            else if t == 22{
                suimin_second = suimin_second + 60*60*2
            }
            let suimin_hour = suimin_second/3600
            let suimin_minute = (suimin_second%3600)/60
            let suimin_second2 = (suimin_second%3600)%60
            var date_String = String(format: "%2d %2d %02d %02d %02d \n",comps.month!,comps.day!,suimin_hour,suimin_minute,suimin_second2)
            
            print("date_String\(date_String)")
            let documentsPath_2 = NSHomeDirectory() + "/Documents"
            let file_path_2 = documentsPath_2 + "/睡眠時間.txt"
            print("file_path_2\(file_path_2)")
            let fileurl = URL(fileURLWithPath: file_path_2)
            let stream = OutputStream(url: fileurl, append: true)
            stream?.open()
            let data = date_String.data(using: .utf8)
            let result = data?.withUnsafeBytes {
                stream?.write($0, maxLength: (data?.count)!)
            }
        }
        catch{
            print("error")
        }
    }
}
