//
//  AppDelegate.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/07
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        print("aaa")
        let suimin = Filewrite()
        application.cancelAllLocalNotifications()
        
        suimin.a()
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        application.cancelAllLocalNotifications()
        
        let notification = UILocalNotification()
        notification.alertAction = "アプリに戻る"
        notification.alertBody = "ランキングが更新されました"
        notification.fireDate = NSDate(timeIntervalSinceNow:10) as Date
        notification.soundName = UILocalNotificationDefaultSoundName
        // アイコンバッジに1を表示
        notification.applicationIconBadgeNumber = 1
        // あとのためにIdを割り振っておく
        notification.userInfo = ["notifyId": "ranking_update"]
        application.scheduleLocalNotification(notification)
        var i = 0
        var count = 1
        counter = 0
        while i == 0 {
            if count%100000000 == 0{
                let date = NSDate()
                let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
                let calendarComponents = calendar.components(.hour, from: date as Date)
                let calendarComponents2 = calendar.components(.minute, from: date as Date)
                let calendarComponents3 = calendar.components(.second, from: date as Date)
                let hour = calendarComponents.hour
                let minute = calendarComponents2.minute
                let second = calendarComponents3.second
                var String_a = String(format: "%2d %2d %02d \n",hour!,minute!,second!)
                print(String_a)
                if hour == 23 && minute == 53 && second! <= 2{
                    suimin.sleep_time()
                    break
                }
            }
            count += 1
        }
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

