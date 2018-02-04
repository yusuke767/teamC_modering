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
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
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
        
        if 4 < hour! && hour! <= 12 {
            if count == 0{
                suimin_2.sleep_time()
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
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

