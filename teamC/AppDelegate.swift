//
//  AppDelegate.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/07
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var count = 0
    var check = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //初回起動時にtextがない場合、デフォルトの時間書き込み
        let sleep = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let comps = calendar.components([.year, .month, .day, .hour, .minute, .second], from: sleep as Date)
        
        let documentsPath = NSHomeDirectory() + "/Documents"
        let file_path1 = documentsPath + "/slept_time.txt"
        let file_path2 = documentsPath + "/睡眠時間.txt"
        
        let checkValidation = FileManager.default
        do{
            if (checkValidation.fileExists(atPath: file_path1)){
                print("slept_time.txtは存在する")
            }else{
                let first_slept_time = "22:00:00\n"
                try first_slept_time.write(toFile: file_path1, atomically: true, encoding: String.Encoding.utf8)
            }
        }
        catch{
        }
        do{
            if (checkValidation.fileExists(atPath: file_path2)){
                print("睡眠時間.txtは存在する")
            }else{
                let first_sleep_time = String(format: "%2d %2d 04 00 00 \n",comps.month!,comps.day!)
                try first_sleep_time.write(toFile: file_path2, atomically: true, encoding: String.Encoding.utf8)
            }
        }
        catch{
        }
 
 
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        
        //初回起動時だけ実行
        let file_name = "体力.txt"
        let file_name_2 = "好感度.txt"
        let file_name_3 = "カウント.txt"
        let userDefault = UserDefaults.standard
        let dict = ["firstLaunch": true]
        userDefault.register(defaults: dict)
        if userDefault.bool(forKey: "firstLaunch") {
            userDefault.set(false, forKey: "firstLaunch")
            if let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first {
                let path_file_name = dir.appendingPathComponent( file_name )
                let path_file_name_2 = dir.appendingPathComponent( file_name_2 )
                let path_file_name_3 = dir.appendingPathComponent( file_name_3 )
                let text_hp = "100"
                let text_exp = "0"
                let text_count = "0"
                do {
                    try text_hp.write( to: path_file_name, atomically: false, encoding: String.Encoding.utf8 )
                    try text_exp.write( to: path_file_name_2, atomically: false, encoding: String.Encoding.utf8 )
                    try text_count.write( to: path_file_name_3, atomically: false, encoding: String.Encoding.utf8 )
                } catch {
                    print("初回書き込みエラー")
                }
            }
            print("初回起動時実行")
        }
        
        //aaa
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
            if error != nil {
                return
            }
            
            if granted {
                debugPrint("通知許可")
            } else {
                debugPrint("通知拒否")
            }
        })
        
        return true
    }
    

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let calendarComponents = calendar.components(.hour, from: date as Date)
        let hour = calendarComponents.hour
        if hour! >= 22 || hour! <= 4{//count のリセット
            count = 0
        }
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("アプリを開きそうな時に呼ばれる")
        
        let suimin_2 = Filewrite()
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let calendarComponents = calendar.components(.hour, from: date as Date)
        let hour = calendarComponents.hour
        
        let tairyoku : CharacterHP = CharacterHP()
        
        if 4 < hour! && hour! <= 12 {
            if count == 0{
                suimin_2.sleep_time()
                tairyoku.CharaHP()
            }
            count += 1
        }
        else if hour! >= 22 || hour! <= 4{
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let b = formatter.string(from: date as Date)
            let d: String = String(b)
            let documentsPath = NSHomeDirectory() + "/Documents"
            let file_path = documentsPath + "/slept_time.txt"
            do {
                try d.write(toFile: file_path, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("aaa")
                // Failed to write file
            }
        }
        
        //ファイルパス
        let documentsPath = NSHomeDirectory() + "/Documents"
        let file_path = documentsPath + "/体力.txt"
        let file_path_2 = documentsPath + "/好感度.txt"
        do {
            //体力の数値を"CharaHP"に保存
            let CharaHP = try String( contentsOfFile: file_path, encoding: String.Encoding.utf8 )
            print("体力\(CharaHP)")
            //好感度の数値を"CharaEXP"に保存
            let CharaEXP = try String( contentsOfFile: file_path_2, encoding: String.Encoding.utf8 )
            print("好感度\(CharaEXP)")
        } catch {
            print("エラー")
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

