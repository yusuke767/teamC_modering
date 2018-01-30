//
//  Collection.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/08.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

class Collection:UIViewController , UITabBarDelegate , UIScrollViewDelegate {
    private var myTabBar:MyTabBar!
    private var myScrollView: UIScrollView!
    private var colleButton:UIButton!
    private var myWindow: UIWindow!
    private var myWindowButton: UIButton!

    // Tableで使用する配列を設定する
    var sickName: [String] = ["乳がん(癌)","下痢","鬱","肺炎","睡眠時無呼吸症候群"]     //病名
    var Symptom: [String] = ["乳房のしこり、他の癌への転移、そして死亡。。。","下痢による脱水症状で最悪の場合死に至る","鬱により人間不信や自殺願望が芽生える可能性がある","長い期間咳が続き高熱になる","睡眠中窒息の状態が続く"]   //症状
    var Cause: [String] = ["睡眠不足により癌を倒す免疫細胞が眠った状態になり癌のリスクを高める","内臓の働きが寝不足により不規則になる","寝不足による精神的不安定な状況に陥る","睡眠不足による免疫力の低下が原因","睡眠時間の乱れによる食習慣の悪影響や運動不足"] //原因
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面を表示
        self.view.backgroundColor = UIColor.black
        
        //スクロール
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.black
        // 表示窓のサイズと位置を設定
        scrollView.frame.size = CGSize(width: self.view.frame.width , height: self.view.frame.height - 200)
        scrollView.center = self.view.center
        // 中身の大きさを設定
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 5050)
        // スクロールの跳ね返り
        scrollView.bounces = false
        // スクロールバーの見た目と余白
        scrollView.indicatorStyle = .black
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // Delegate を設定
        scrollView.delegate = self
     
    
        // ScrollViewの中身を作る
        //button生成
        for i in 0...4{
            colleButton = UIButton()
            // ボタンのサイズ.
            let bWidth: CGFloat = self.view.frame.width - 100
            let bHeight: CGFloat = 200
            // ボタンの設置座標とサイズを設定する.
            colleButton.frame = CGRect(x: self.view.frame.width/2 - bWidth/2, y: CGFloat(50 + 250 * i) , width: bWidth, height: bHeight)
            // ボタンの枠を丸くする.
            colleButton.layer.masksToBounds = true
            // コーナーの半径を設定する.
            colleButton.layer.cornerRadius = 20.0
            // ボタンの背景色を設定.
            colleButton.backgroundColor = UIColor.red
            // タイトルを設定する
            colleButton.setTitle("No.\(String(i + 1))     \(sickName[i])", for: .normal)
            colleButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
            colleButton.setTitleColor(UIColor.white, for: .normal)
            // タイトルを設定する(ボタンがハイライトされた時).
            colleButton.setTitleColor(UIColor.black, for: .highlighted)
            // ボタンにタグをつける.
            colleButton.tag = i + 1
            // イベントを追加する
            colleButton.addTarget(self, action: #selector(Collection.onClickMyButton(sender:)), for: .touchUpInside)
            // ボタンをViewに追加.
            scrollView.addSubview(colleButton)
        }
        
        self.view.addSubview(scrollView)
        
        // Labelを作成.
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        // UILabelの背景をオレンジ色に.
        label.backgroundColor = UIColor.red
        // 文字の色を白に定義.
        label.textColor = UIColor.white
        // UILabelに文字を代入.
        label.text = "病気図鑑"
        //文字サイズ
        label.font = UIFont.systemFont(ofSize:30)
        // 文字の影をグレーに定義.
        label.shadowColor = UIColor.gray
        // Textを中央寄せにする.
        label.textAlignment = NSTextAlignment.center
        // ViewにLabelを追加.
        self.view.addSubview(label)

        
        //tabbar
        let width = self.view.frame.width
        let height = self.view.frame.height
        //デフォルト
        let tabBarHeight:CGFloat = 100
        /**   TabBarを設置   **/
        myTabBar = MyTabBar()
        myTabBar.frame = CGRect(x:0,y:height - tabBarHeight,width:width,height:tabBarHeight)
        //バーの色
        myTabBar.barTintColor = UIColor.lightGray
        //選択されていないボタンの色
        myTabBar.unselectedItemTintColor = UIColor.white
        //ボタンを生成
        let home:UITabBarItem = UITabBarItem(title: "ホーム", image: UIImage(named:"home2.png") , tag: 1)
        //myTabBar.tintColor = UIColor.blue
        let lib:UITabBarItem = UITabBarItem(title: "図鑑", image: UIImage(named:"book3.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), tag: 2)
        let calle:UITabBarItem = UITabBarItem(title: "カレンダー", image: UIImage(named:"cale.png") , tag: 3)
        //ボタンをタブバーに配置する
        myTabBar.items = [home,lib,calle]
        //デリゲートを設定する
        myTabBar.delegate = self
        self.view.addSubview(myTabBar)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // スクロール中の処理
        print("didScroll")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // ドラッグ開始時の処理
        print("beginDragging")
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag{
        case 1:
            self.myWindow = nil;
            let myViewController: UIViewController = SecondViewController()// 遷移するViewを定義する.
            myViewController.modalTransitionStyle = .crossDissolve
            self.present(myViewController, animated: true, completion: nil)
        case 2:
            self.myWindow = nil;
            let myViewController: UIViewController = Collection()// 遷移するViewを定義する.
            myViewController.modalTransitionStyle = .crossDissolve
            self.present(myViewController, animated: true, completion: nil)
        case 3:
            self.myWindow = nil;
            let myViewController: UIViewController = calendarView()// 遷移するViewを定義する.
            myViewController.modalTransitionStyle = .crossDissolve
            self.present(myViewController, animated: true, completion: nil)
        default : return
            
        }
    }
    /*
     自作Windowを生成する
     */
    func makeMyWindow(s: Int){
        myWindow = UIWindow()
        myWindowButton = UIButton()
        
        // 背景を白に設定する.
        myWindow.backgroundColor = UIColor.white
        myWindow.frame = CGRect(x:0, y:0, width:400, height:450)
        myWindow.layer.position = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
        myWindow.alpha = 0.8
        myWindow.layer.cornerRadius = 20
        
        // myWindowをkeyWindowにする.
        myWindow.makeKey()
        
        // windowを表示する.
        self.myWindow.makeKeyAndVisible()
        
        // ボタンを作成する.
        myWindowButton.frame = CGRect(x:0, y:0, width:100, height:60)
        myWindowButton.backgroundColor = UIColor.orange
        myWindowButton.setTitle("Close", for: .normal)
        myWindowButton.setTitleColor(UIColor.white, for: .normal)
        myWindowButton.layer.masksToBounds = true
        myWindowButton.layer.cornerRadius = 20.0
        myWindowButton.layer.position = CGPoint(x:self.myWindow.frame.width/2, y:self.myWindow.frame.height-50)
        myWindowButton.addTarget(self, action: #selector(Collection.CloseButton(sender:)), for: .touchUpInside)
        self.myWindow.addSubview(myWindowButton)
        
        // TextViewを作成する.
        let myTextView: UITextView = UITextView(frame: CGRect(x:10, y:10, width:self.myWindow.frame.width - 20, height:350))
        myTextView.backgroundColor = UIColor.white
        myTextView.text = """
        No.\(String(s))
        病名:\(sickName[s - 1])
        症状:\(Symptom[s - 1])
        原因:\(Cause[s - 1])
        """
        myTextView.font = UIFont.systemFont(ofSize: 25)
        myTextView.textColor = UIColor.black
        myTextView.textAlignment = NSTextAlignment.left
        myTextView.isEditable = false
        
        self.myWindow.addSubview(myTextView)
    }
    
    /*
     ボタンのイベント.
     */
    @objc internal func onClickMyButton(sender: UIButton) {
        let s = sender.tag
        makeMyWindow(s: s)
        print("sender.tag: \(sender.tag)")
        
    }
    
    @objc func CloseButton(sender: UIButton) {
        myWindow.isHidden = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
