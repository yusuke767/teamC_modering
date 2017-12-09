//
//  SecondViewController.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/07.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate,UITabBarDelegate  {
    private var dateTextField: UITextField!
    private var myTabBar:MyTabBar!
    private var hpBar:UIProgressView!
    private var datelabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景
        self.view.backgroundColor = UIColor.white
        // 画像を設定する.
        let myImage: UIImage = UIImage(named: "ももこ.png")!
        let imageWidth: CGFloat = view.frame.size.width
        let imageHeight: CGFloat = view.frame.size.height
        let downPosX: CGFloat = (self.view.bounds.width - imageWidth) / 2
        let downPosY: CGFloat = 250
        // 表示用のUIImageViewを生成.
        let myScaleDownView: UIImageView = UIImageView(frame:  CGRect(x: downPosX, y: downPosY, width: imageWidth, height: imageHeight))
        // UIImageViewに画像を設定する.
        myScaleDownView.image = myImage
        // アフィン行列を生成する.
        myScaleDownView.transform = CGAffineTransform(scaleX: 1, y: 1)
        // Viewに追加する.
        self.view.addSubview(myScaleDownView)
        
    //date表示
        
        // 1秒ごとに「displayClock」を実行する
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(displayClock), userInfo: nil, repeats: true)
        timer.fire()    // 無くても動くけどこれが無いと初回の実行がラグる
        
        
        
    //ラベル
        let label = UILabel()
        label.text = "HP"
        label.font = UIFont(name: "HiraMinProN-W3", size: 30)
        label.sizeToFit()
        label.center = CGPoint(x: 200, y: 100) // UILabelの中央座標を (200, 100) にする
        label.layer.position = CGPoint(x: 150 , y: self.view.frame.height - 200)
        self.view.addSubview(label)
        
        //HPバー
        // ProgressViewを作成する.
        hpBar = UIProgressView(frame: CGRect(x:0, y:0, width:400, height:10))
        hpBar.progressTintColor = UIColor.green
        hpBar.trackTintColor = UIColor.white
        // 座標を設定する.
        hpBar.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 200 )
        // バーの高さを設定する(横に1.0倍,縦に2.0倍).
        hpBar.transform = CGAffineTransform(scaleX: 1.0, y: 7.0)
        // 進捗具合を設定する(0.0~1.0).
        hpBar.progress = 0.3
        // アニメーションを付ける.
       hpBar.setProgress(1.0, animated: true)
        // Viewに追加する.
        self.view.addSubview(hpBar)
        
        
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
        //ボタンを押した時の色
        myTabBar.tintColor = UIColor.blue
        //ボタンを生成
        //文字と画像
        let home:UITabBarItem = UITabBarItem(title: "ホーム", image: UIImage(named:"home2.png"), tag: 1)
        let lib:UITabBarItem = UITabBarItem(title: "図鑑", image: UIImage(named:"book3.png"), tag: 2)
        let calle:UITabBarItem = UITabBarItem(title: "カレンダー", image: UIImage(named:"cale.png"), tag: 3)
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
            let myViewController: UIViewController = calendar()// 遷移するViewを定義する.
            myViewController.modalTransitionStyle = .crossDissolve
            self.present(myViewController, animated: true, completion: nil)
    
        default : return
            
        }
    }
    
    // 現在時刻を表示する処理
    @objc func displayClock() {
        datelabel = UILabel()
        datelabel.font = UIFont(name: "HiraKakuInterface-W1", size:UIFont.labelFontSize)
        datelabel.frame = CGRect(x: 0, y: self.view.bounds.height/2, width: self.view.bounds.width, height: 20)
        datelabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(datelabel)
        datelabel.text = ""
        // 現在時刻を「HH:MM:SS」形式で取得する
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        var displayTime = formatter.string(from: Date())    // Date()だけで現在時刻を表す
        // 0から始まる時刻の場合は「 H:MM:SS」形式にする
        if displayTime.hasPrefix("0") {
            // 最初に見つかった0だけ削除(スペース埋め)される
            if let range = displayTime.range(of: "0") {
                displayTime.replaceSubrange(range, with: " ")
            }
        }
        // ラベルに表示
        
        datelabel.text = displayTime
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
