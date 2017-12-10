//
//  calendar.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/07.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit
import FSCalendar

class calendarView: UIViewController , UITabBarDelegate , FSCalendarDataSource , FSCalendarDelegate{
    private var myTabBar:MyTabBar!
    fileprivate weak var calendar: FSCalendar!
    private var coleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面を表示
        self.view.backgroundColor = UIColor.white
        
    // Labelを作成.
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        // UILabelの背景をオレンジ色に.
        label.backgroundColor = UIColor.orange
        // 文字の色を白に定義.
        label.textColor = UIColor.white
        // UILabelに文字を代入.
        label.text = "カレンダー"
        //文字サイズ
        label.font = UIFont.systemFont(ofSize:30)
        // 文字の影をグレーに定義.
        label.shadowColor = UIColor.gray
        // Textを中央寄せにする.
        label.textAlignment = NSTextAlignment.center
        // ViewにLabelを追加.
        self.view.addSubview(label)
        
    //カレンダー
        let calendar = FSCalendar(frame: CGRect(x:50, y: 100, width:self.view.frame.width - 100 , height: self.view.frame.height - 200))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        
       
        
        //tabbar
        let width = self.view.frame.width
        let height = self.view.frame.height
        //デフォルトは49
        let tabBarHeight:CGFloat = 100
        /**   TabBarを設置   **/
        myTabBar = MyTabBar()
        myTabBar.frame = CGRect(x:0,y:height - tabBarHeight,width:width,height:tabBarHeight)
        //バーの色
        myTabBar.barTintColor = UIColor.lightGray
        //選択されていないボタンの色
        myTabBar.unselectedItemTintColor = UIColor.white
        //ボタンを生成
        let home:UITabBarItem = UITabBarItem(title: "ホーム", image: UIImage(named:"home2.png"), tag: 1)
        let lib:UITabBarItem = UITabBarItem(title: "図鑑", image: UIImage(named:"book3.png"), tag: 2)
        let calle:UITabBarItem = UITabBarItem(title: "カレンダー", image: UIImage(named:"cale.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), tag: 3)
        
        //ボタンをタブバーに配置する
        myTabBar.items = [home,lib,calle]
        //デリゲートを設定する
        myTabBar.delegate = self
        self.view.addSubview(myTabBar)
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag{
        case 1:
            let myViewController: UIViewController = SecondViewController()// 遷移するViewを定義する.
            myViewController.modalTransitionStyle = .crossDissolve
            self.present(myViewController, animated: true, completion: nil)
        case 2:
            let myViewController: UIViewController = Collection()// 遷移するViewを定義する.
            myViewController.modalTransitionStyle = .crossDissolve
            self.present(myViewController, animated: true, completion: nil)
        case 3:
            let myViewController: UIViewController = calendarView()// 遷移するViewを定義する.
            myViewController.modalTransitionStyle = .crossDissolve
            self.present(myViewController, animated: true, completion: nil)
        default : return
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
