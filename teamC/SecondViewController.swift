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
    private var dateLabel = UILabel()
    private var sleepLabel = UILabel()
    
    // 日時フォーマット
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景
        self.view.backgroundColor = UIColor.white
        setBackgroundImage()

        // 画像を設定する.
        let myImage: UIImage = UIImage(named: "ももこ.png")!
        let imageWidth: CGFloat = 1241 / 3
        let imageHeight: CGFloat = 2105 / 3
        let downPosX: CGFloat = (self.view.bounds.width - imageWidth) / 2
        let downPosY: CGFloat = 150
        // 表示用のUIImageViewを生成.
        let myScaleDownView: UIImageView = UIImageView(frame:  CGRect(x: downPosX, y: downPosY, width: imageWidth, height: imageHeight))
        // UIImageViewに画像を設定する.
        myScaleDownView.image = myImage
        // アフィン行列を生成する.
        myScaleDownView.transform = CGAffineTransform(scaleX: 1, y: 1)
        // Viewに追加する.
        self.view.addSubview(myScaleDownView)
        
    //date表示
        dateLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3, height: 80)
        dateLabel.layer.position = CGPoint(x: 200 , y: 100)
        //　ラベル枠の枠線太さと色
        dateLabel.layer.borderColor = UIColor.black.cgColor
        dateLabel.layer.borderWidth = 2
        //文字サイズ
        dateLabel.font = UIFont.systemFont(ofSize:25)
        // Textを中央寄せにする.
        dateLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(dateLabel)
        // 初回
        updateDateLabel()
        // 一定間隔で実行
        let time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDateLabel), userInfo: nil, repeats: true)
        time.fire()    // 無くても動くけどこれが無いと初回の実行がラグる
        
    //睡眠時間
        sleepLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3, height: 80)
        sleepLabel.layer.position = CGPoint(x: 650 , y: 100)
        //　ラベル枠の枠線太さと色
        sleepLabel.layer.borderColor = UIColor.black.cgColor
        sleepLabel.layer.borderWidth = 2
        sleepLabel.text = """
        前回の睡眠時間
        Test1
        """
        sleepLabel.numberOfLines = 0
        //文字サイズ
        sleepLabel.font = UIFont.systemFont(ofSize:25)
        // Textを中央寄せにする.
        sleepLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(sleepLabel)
        
        
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
        //ボタンを生成
        //文字と画像
        let home:UITabBarItem = UITabBarItem(title: "ホーム", image: UIImage(named:"home2.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), tag: 1)
        let lib:UITabBarItem = UITabBarItem(title: "図鑑", image: UIImage(named:"book3.png"), tag: 2)
        let calle:UITabBarItem = UITabBarItem(title: "カレンダー", image: UIImage(named:"cale.png"), tag: 3)
        //ボタンをタブバーに配置する
        myTabBar.items = [home,lib,calle]
        //デリゲートを設定する
        myTabBar.delegate = self
        self.view.addSubview(myTabBar)
        
        
    }
    
    //背景画像設定
    func setBackgroundImage() {
        var imageView:UIImageView!
        // インスタンスの生成
        let image = UIImage(named:"部屋背景.png")!
        imageView = UIImageView(image:image)
        //画面幅取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        // 画像の幅・高さの取得
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = screenWidth / width
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        //画像をUIImageViewの左上に表示
        self.view.contentMode = UIViewContentMode.topLeft
        // 画像を追加し、最背面に設定
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack:  imageView)
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
    
    @objc func updateDateLabel(){
        let now = NSDate()
        dateLabel.text = dateFormatter.string(from: now as Date)
    }

    
}
