//
//  calendar.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/07.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

extension UIView {
    
    enum BorderPosition {
        case Top
        case Right
        case Bottom
        case Left
    }
    
    func border(borderWidth: CGFloat, borderColor: UIColor?, borderRadius: CGFloat?) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        if let _ = borderRadius {
            self.layer.cornerRadius = borderRadius!
        }
        self.layer.masksToBounds = true
    }
    
    func border(positions: [BorderPosition], borderWidth: CGFloat, borderColor: UIColor?) {
        
        let topLine = CALayer()
        let leftLine = CALayer()
        let bottomLine = CALayer()
        let rightLine = CALayer()
        
        self.layer.sublayers = nil
        self.layer.masksToBounds = true
        
        if let _ = borderColor {
            topLine.backgroundColor = borderColor!.cgColor
            leftLine.backgroundColor = borderColor!.cgColor
            bottomLine.backgroundColor = borderColor!.cgColor
            rightLine.backgroundColor = borderColor!.cgColor
        } else {
            topLine.backgroundColor = UIColor.white.cgColor
            leftLine.backgroundColor = UIColor.white.cgColor
            bottomLine.backgroundColor = UIColor.white.cgColor
            rightLine.backgroundColor = UIColor.white.cgColor
        }
        
        if positions.contains(.Top) {
            topLine.frame = CGRect(x:0.0, y:0.0, width:self.frame.width, height:borderWidth)
            self.layer.addSublayer(topLine)
        }
        if positions.contains(.Left) {
            leftLine.frame = CGRect(x:0.0,y: 0.0, width:borderWidth,height: self.frame.height)
            self.layer.addSublayer(leftLine)
        }
        if positions.contains(.Bottom) {
            bottomLine.frame = CGRect(x:0.0,y: self.frame.height - borderWidth, width:self.frame.width, height:borderWidth)
            self.layer.addSublayer(bottomLine)
        }
        if positions.contains(.Right) {
            rightLine.frame = CGRect(x:self.frame.width - borderWidth, y:0.0,width: borderWidth, height:self.frame.height)
            self.layer.addSublayer(rightLine)
        }
        
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let _ = self.layer.borderColor {
                return UIColor(cgColor: self.layer.borderColor!)
            }
            return nil
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}

class calendarView: UIViewController , UITabBarDelegate , UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    private var myTabBar:MyTabBar!
    private var coleView: UIView!
    private var myCollectView:UICollectionView!
    private var myWindow: UIWindow!
    private var myWindowButton: UIButton!
    
    //セルの余白
    let cellMargin:CGFloat = 2.0
    //１週間に何日あるか(行数)
    let daysPerWeek:Int = 7
    
    let dateManager = DateManager()
    var startDate:Date!
    
    let weekArray = ["sun","Mon","Tre","Wed","Thu","Fri","Sat"]
    //表示する年月のラベル
    private var monthLabel:UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面を表示
        self.view.backgroundColor = UIColor.blue
        
        // Labelを作成.
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 11.12))
        // UILabelの背景をオレンジ色に.
        label.backgroundColor = UIColor.red
        // 文字の色を白に定義.
        label.textColor = UIColor.white
        // UILabelに文字を代入.
        label.text = "カレンダー"
        //文字サイズ
        label.font = UIFont.systemFont(ofSize: (self.view.frame.width + self.view.frame.height) / 64.87)
        // 文字の影をグレーに定義.
        label.shadowColor = UIColor.gray
        // Textを中央寄せにする.
        label.textAlignment = NSTextAlignment.center
        // ViewにLabelを追加.
        self.view.addSubview(label)
        
        //カレンダー
        
        let barHeight = UIApplication.shared.statusBarFrame.size.height
        let width = self.view.frame.width
        let height = self.view.frame.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0)
        //print(barHeight)
        //コレクションビューを設置
        myCollectView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectView.frame = CGRect(x:0,y:self.view.frame.height / 11.12,width:width,height:height - self.view.frame.height / 11.12 - self.view.frame.height / 11.12)//barHeight + 50
        myCollectView.register(CalendarCell.self, forCellWithReuseIdentifier: "collectCell")
        myCollectView.delegate = self
        myCollectView.dataSource = self
        myCollectView.backgroundColor = .white
        
        self.view.addSubview(myCollectView)
        
        let date = Date()
        var components = NSCalendar.current.dateComponents([.year ,.month, .day], from:date)
        components.day = 1
        components.month = 1
        components.year = 2017
        startDate = NSCalendar.current.date(from: components)
        
        let month:Int = Int(dateManager.monthTag(row:6,startDate:startDate))!
        let digit = numberOfDigit(month: month)
        
        monthLabel = UILabel()
        monthLabel.frame = CGRect(x:0,y:0,width:width,height:height)//200
        monthLabel.center = CGPoint(x:width / 1.25,y:height / 22.24)//100
        monthLabel.textAlignment = .center
        
        if(digit == 5){
            monthLabel.text = String(month / 10) + "年" + String(month % 10) + "月"
        }else if(digit == 6){
            monthLabel.text = String(month / 100) + "年" + String(month % 100) + "月"
        }
        self.view.addSubview(monthLabel)
        
        
        //tabbar
        let tabwidth = self.view.frame.width
        let tabheight = self.view.frame.height
        //デフォルトは49
        let tabBarHeight:CGFloat = self.view.frame.height / 11.12
        /**   TabBarを設置   **/
        myTabBar = MyTabBar()
        myTabBar.frame = CGRect(x:0,y:tabheight - tabBarHeight,width:tabwidth,height:tabBarHeight)
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
    
    override func viewDidAppear(_ animated: Bool){
        myCollectView.setContentOffset(CGPoint(x:0,y:self.myCollectView.contentSize.height - self.myCollectView.frame.size.height), animated: false)
    }
    
    //セクションの数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //レイアウト調整 行間余白
    func collectionView(_ collectionView:UICollectionView,layout collectionViewLayout:UICollectionViewLayout,minimumLineSpacingForSectionAt section:Int) -> CGFloat{
        return cellMargin
    }
    
    //レイアウト調整　列間余白
    func collectionView(_ collectionView:UICollectionView,layout collectionViewLayout:UICollectionViewLayout,minimumInteritemSpacingForSectionAt section:Int) -> CGFloat{
        return cellMargin
    }
    
    
    //セルのサイズを設定
    func collectionView(_ collectionView:UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath:IndexPath) -> CGSize{
        let numberOfMargin:CGFloat = 8.0
        let width:CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height:CGFloat = width * 1.5
        return CGSize(width:width,height:height)
    }
    
    //選択した時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("押された")
        print(dateManager.monthTag(row:indexPath.row,startDate:startDate))
        print(dateManager.conversionDateFormat(row:indexPath.row,startDate:startDate))
        let ym = dateManager.monthTag(row:indexPath.row,startDate:startDate)
        let d = dateManager.conversionDateFormat(row:indexPath.row,startDate:startDate)
        let s = Int(ym + d)!
        sleepTimeWindow(s:s)
    }
    
    //セルの総数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateManager.cellCount(startDate:startDate)
    }
    
    //セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CalendarCell = collectionView.dequeueReusableCell(withReuseIdentifier:"collectCell",for:indexPath as IndexPath) as! CalendarCell
        
        //土曜日は赤　日曜日は青　にテキストカラーを変更する
        if(indexPath.row % 7 == 0){
            cell.textLabel.textColor = UIColor.red
        }else if(indexPath.row % 7 == 6){
            cell.textLabel.textColor = UIColor.blue
        }else{
            cell.textLabel.textColor = UIColor.gray
        }
        //cellのtagつけ
        cell.tag = Int(dateManager.monthTag(row:indexPath.row,startDate:startDate))!
        //セルの日付を取得し
        cell.textLabel.text = dateManager.conversionDateFormat(row:indexPath.row,startDate:startDate)
        //セルの日付を取得
        let day = Int(dateManager.conversionDateFormat(row:indexPath.row,startDate:startDate!))!
        if(day == 1){
            cell.textLabel.border(positions:[.Top,.Left],borderWidth:1,borderColor:UIColor.black)
        }else if(day <= 7){
            cell.textLabel.border(positions:[.Top],borderWidth:1,borderColor:UIColor.black)
        }else{
            cell.textLabel.border(positions:[.Top],borderWidth:0,borderColor:UIColor.white)
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCell = myCollectView.visibleCells.filter{
            return myCollectView.bounds.contains($0.frame)
        }
        
        var visibleCellTag = Array<Int>()
        if(visibleCell != []){
            visibleCellTag = visibleCell.map{$0.tag}
            //月は奇数か偶数か　割り切れるものだけを取り出す
            let even = visibleCellTag.filter{
                return $0 % 2 == 0
            }
            let odd = visibleCellTag.filter{
                return $0 % 2 != 0
            }
            //oddかevenの多い方を返す
            let month = even.count >= odd.count ? even[0] : odd[0]
            
            //桁数によって分岐
            let digit = numberOfDigit(month: month)
            if(digit == 5){
                monthLabel.text = String(month / 10) + "年" + String(month % 10) + "月"
            }else if(digit == 6){
                monthLabel.text = String(month / 100) + "年" + String(month % 100) + "月"
            }
        }
    }
    
    func numberOfDigit(month:Int) -> Int{
        var num = month
        var cnt = 1
        while(num / 10 != 0){
            cnt = cnt + 1
            num = num / 10
        }
        return cnt
        
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
    
    func sleepTimeWindow(s: Int){
        myWindow = UIWindow()
        myWindowButton = UIButton()
        
        // 背景を白に設定する.
        myWindow.backgroundColor = UIColor.red
        myWindow.frame = CGRect(x:0, y:0, width: self.view.frame.width / 2.085, height: self.view.frame.height / 2.47)
        myWindow.layer.position = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
        myWindow.alpha = 1  //0.8
        myWindow.layer.cornerRadius = 20
        
        // myWindowをkeyWindowにする.
        myWindow.makeKey()
        
        // windowを表示する.
        self.myWindow.makeKeyAndVisible()
        
        
        //print(self.myWindow.frame.width)
        // TextViewを作成する.
        let myTextView: UITextView = UITextView(frame: CGRect(x:self.myWindow.frame.width / 14, y:20, width:self.view.frame.width / 2.4 , height: self.myWindow.frame.height /  1.4))//width:self.myWindow.frame.width / 1.05 h1.285
        myTextView.backgroundColor = UIColor.white
        print(s)
        myTextView.text = """
        \(String(s))
        """
        myTextView.font = UIFont.systemFont(ofSize: (self.view.frame.width + self.view.frame.height) / 77.84)
        myTextView.textColor = UIColor.black
        myTextView.textAlignment = NSTextAlignment.left
        myTextView.isEditable = false
        
        self.myWindow.addSubview(myTextView)
        
        // ボタンを作成する.
        myWindowButton.frame = CGRect(x:0, y:0, width: self.myWindow.frame.width / 2, height: self.view.frame.height / 18.53)
        myWindowButton.backgroundColor = UIColor.orange
        myWindowButton.setTitle("Close", for: .normal)
        myWindowButton.setTitleColor(UIColor.white, for: .normal)
        myWindowButton.layer.masksToBounds = true
        myWindowButton.layer.cornerRadius = 20.0
        //print("bh")
        //print(self.myWindow.frame.height)
        myWindowButton.layer.position = CGPoint(x:self.myWindow.frame.width/2, y:self.myWindow.frame.height / 1.125)
        myWindowButton.addTarget(self, action: #selector(Collection.CloseButton(sender:)), for: .touchUpInside)
        self.myWindow.addSubview(myWindowButton)
    }
    
    @objc func CloseButton(sender: UIButton) {
        myWindow.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
