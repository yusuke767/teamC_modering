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
    private var LevelLabel = UILabel()
    
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
        //キャラクター表示
        setCharacterImage("ももこ.png")

    //date表示
        dateLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3, height: self.view.frame.height / 13.9)
        dateLabel.layer.position = CGPoint(x: self.view.frame.width / 4 , y: self.view.frame.height / 11.12) //3.36
        dateLabel.backgroundColor = UIColor.white
        //　ラベル枠の枠線太さと色
        dateLabel.layer.borderColor = UIColor.black.cgColor
        dateLabel.layer.borderWidth = 2
        //文字サイズ
        dateLabel.font = UIFont.systemFont(ofSize: (self.view.frame.width + self.view.frame.height) / 100)//77.84
        // Textを中央寄せにする.
        dateLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(dateLabel)
        // 初回
        updateDateLabel()
        // 一定間隔で実行
        let time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDateLabel), userInfo: nil, repeats: true)
        time.fire()    // 無くても動くけどこれが無いと初回の実行がラグる
        
        //レベル
        let file_exp = "好感度.txt"
        var exp_data : String = ""
        if let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first {
            let path_file_name = dir.appendingPathComponent( file_exp  )
            do {
                let exp_txt = try String( contentsOf: path_file_name, encoding: String.Encoding.utf8 )
                exp_data = exp_txt
            } catch {
                print("レベル読み込みエラー")
            }
        }
        LevelLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 9, height: self.view.frame.height / 13.9)
        LevelLabel.layer.position = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 11.12)//1.28
        LevelLabel.backgroundColor = UIColor.white
        //　ラベル枠の枠線太さと色
        LevelLabel.layer.borderColor = UIColor.black.cgColor
        LevelLabel.layer.borderWidth = 2
        LevelLabel.text = "レベル\n \(exp_data)"
        LevelLabel.numberOfLines = 0
        //文字サイズ
        LevelLabel.font = UIFont.systemFont(ofSize: (self.view.frame.width + self.view.frame.height) / 100)
        // Textを中央寄せにする.
        LevelLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(LevelLabel)
        
 //睡眠時間
        var count = 0
        let file_sleepTime = "睡眠時間.txt"
        var sleep_yesterday : String = ""
        if let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first {
            let path_file_name = dir.appendingPathComponent( file_sleepTime )
            do {
                let SleepT_data = try String( contentsOf: path_file_name, encoding: String.Encoding.utf8 )
                sleep_yesterday = SleepT_data
                count = 1
            } catch {
                print("前回の睡眠時間読み込みエラー")
            }
        }
        let sleep_t = sleep_yesterday.suffix(10)
        var result = sleep_t.replacingOccurrences(of:" ",with:"")
        result = result.replacingOccurrences(of:"\n",with:"")
        let stime = result.prefix(4)
        let hTime = stime.prefix(2)
        let mTime = stime.suffix(2)
        
        sleepLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 3, height: self.view.frame.height / 13.9)
        sleepLabel.layer.position = CGPoint(x: self.view.frame.width / 1.33, y: self.view.frame.height / 11.12)//1.28
        sleepLabel.backgroundColor = UIColor.white
        //　ラベル枠の枠線太さと色
        sleepLabel.layer.borderColor = UIColor.black.cgColor
        sleepLabel.layer.borderWidth = 2
        if count == 1 {
            sleepLabel.text = "前回の睡眠時間\n \(hTime)時間\(mTime)分"
        }else{
            sleepLabel.text = "前回の睡眠時間\n まだ寝てません"
        }
        sleepLabel.numberOfLines = 0
        //文字サイズ
        sleepLabel.font = UIFont.systemFont(ofSize: (self.view.frame.width + self.view.frame.height) / 100)
        // Textを中央寄せにする.
        sleepLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(sleepLabel)
        
 //ラベル
        let label = UILabel()
        label.text = "HP"
        label.font = UIFont(name: "HiraMinProN-W3", size: (self.view.frame.width + self.view.frame.height) / 64.86)
        label.sizeToFit()
        //label.center = CGPoint(x: 200, y: 100) // UILabelの中央座標を (200, 100) にする
        label.layer.position = CGPoint(x: self.view.frame.width / 5.56, y: self.view.frame.height / 1.22)
        self.view.addSubview(label)
        
        //HPバー
        // ProgressViewを作成する.
        hpBar = UIProgressView(frame: CGRect(x:0, y:0, width: self.view.frame.width / 2.085, height: self.view.frame.height / 111.2))
        hpBar.progressTintColor = UIColor.green
        hpBar.trackTintColor = UIColor.white
        // 座標を設定する.
        hpBar.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height / 1.22)
        // バーの高さを設定する(横に1.0倍,縦に2.0倍).
        hpBar.transform = CGAffineTransform(scaleX: 1.0, y: self.view.frame.height / 158.86)
        // 進捗具合を設定する(0.0~1.0).
        hpBar.progress = 1.0
        // アニメーションを付ける.
        let file_HP = "体力.txt"
        var bar_point : Float = 0
        if let dir = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first {
            let path_file_name = dir.appendingPathComponent( file_HP )
            do {
                let HP_data = try String( contentsOf: path_file_name, encoding: String.Encoding.utf8 )
                bar_point = Float(HP_data)!
            } catch {
                print("HPバー読み込みエラー")
            }
        }
        let hp = bar_point / 100
        //print(bar_point)
        //print(hp)
        hpBar.setProgress(hp, animated: true)
        // Viewに追加する.
        self.view.addSubview(hpBar)
        
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        //デフォルトは49
        let tabBarHeight:CGFloat = self.view.frame.height / 11.12
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
    
    //キャラクター画像設定
    //引数に表示したい画像をいれる
    func setCharacterImage(_ character:String!){
        var imageView:UIImageView!
        // 画像を設定する.
        let image = UIImage(named:character)!
        imageView = UIImageView(image:image)
        //画面幅取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        // 画像の幅・高さの取得
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        // 画像リサイズ
        let scale:CGFloat = screenHeight / (height*1.2)
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        // 画像の中心設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight*3/5)
        //画像をUIImageViewの左上に表示
        self.view.contentMode = UIViewContentMode.topLeft
        // 画像を追加
        self.view.addSubview(imageView)
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
        // 画像サイズをスクリーン高さに合わせる
        let scale:CGFloat = screenHeight / height
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
