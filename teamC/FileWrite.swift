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
    func a(){
        write()
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector:#selector(Filewrite.zyouken), userInfo: nil, repeats: true)
    }
    @objc func write(){
        let n = NSProcessInfo()
        let i = n.systemUptime
        let d: String = String(i)
        do {
            try d.writeToFile("/Users/e165703/モデリングC/modering_c.txt", atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            print("aaa")
            // Failed to write file
        }
        
    }
    @objc func zyouken(){
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let calendarComponents = calendar.components(.Hour, fromDate: date)
        let calendarComponents2 = calendar.components(.Minute, fromDate: date)
        let calendarComponents3 = calendar.components(.Second, fromDate: date)
        let hour = calendarComponents.hour
        let minute = calendarComponents2.minute
        let second = calendarComponents3.second
        
        if hour == 11 && minute == 15 && second <= 5{
            
            let suimin_time = Filewrite()
            suimin_time.sleep_time()
        }
    }
    @objc func slept_time(){
        let a = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let b = formatter.stringFromDate(a)
        let d: String = String(b)
        do {
            try d.writeToFile("/Users/e165703/モデリングC/slept_time.txt", atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            print("aaa")
            // Failed to write file
        }
        
    }
    @objc func sleep_time(){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Tokyo")
        dateFormatter.locale = NSLocale(localeIdentifier: "ja")
        dateFormatter.dateFormat = "hh:mm:ss"
        let sleep = NSDate()
        let sleep2 = formatter.stringFromDate(sleep)
        let sleep3: String = String(sleep2)
        print(sleep2)
        do {
            let text = try String(contentsOfFile: "/Users/e165703/モデリングC/slept_time.txt", encoding: NSUTF8StringEncoding)
            let get_up = sleep3.componentsSeparatedByString(":")
            let sleeptime = text.componentsSeparatedByString(":")
            
            var getup_hour: Int = Int(get_up[0])!
            getup_hour = 60*60*getup_hour
            
            var getup_minute: Int = Int(get_up[1])!
            getup_minute = 60*getup_minute
            var getup_second: Int = Int(get_up[2])!
            var getup_all = getup_hour+getup_second+getup_minute
            print(getup_all)
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
            print(sleeptime_all)
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
            var date_String = String(format: "%02d %02d %02d",suimin_hour,suimin_minute,suimin_second2)
            print("睡眠時間は"+date_String+"です")
            try date_String.writeToFile("/Users/e165703/モデリングC/睡眠時間.txt", atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            print("error")
        }
    }
}

