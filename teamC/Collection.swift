//
//  Collection.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/08.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit

class Collection:UIViewController , UITabBarDelegate , UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource {
    private var myTabBar:MyTabBar!
    private var myScrollView: UIScrollView!

    // Tableで使用する配列を設定する
    private let myItems: NSArray = ["TEST1", "TEST2", "TEST3"]
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画面を表示
        //self.view.backgroundColor = UIColor.white
        
        //スクロール
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        // 表示窓のサイズと位置を設定
        scrollView.frame.size = CGSize(width: self.view.frame.width , height: self.view.frame.height - 200)
        scrollView.center = self.view.center
        // 中身の大きさを設定
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 3)
        // スクロールの跳ね返り
        scrollView.bounces = false
        // スクロールバーの見た目と余白
        scrollView.indicatorStyle = .black
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // Delegate を設定
        scrollView.delegate = self
        
        // ScrollViewの中身を作る
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        // TableViewの生成(Status barの高さをずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        // DataSourceを自身に設定する.
        myTableView.dataSource = self
        // Delegateを自身に設定する.
        myTableView.delegate = self
        // Viewに追加する.
        scrollView.addSubview(myTableView)
        
        self.view.addSubview(scrollView)
        
        // Labelを作成.
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        // UILabelの背景をオレンジ色に.
        label.backgroundColor = UIColor.orange
        // 文字の色を白に定義.
        label.textColor = UIColor.white
        // UILabelに文字を代入.
        label.text = "病気図鑑"
        //文字サイズ
        label.font = UIFont.systemFont(ofSize:30);
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
        //ボタンを押した時の色
        myTabBar.tintColor = UIColor.blue
        //ボタンを生成
        let home:UITabBarItem = UITabBarItem(title: "ホーム", image: UIImage(named:"home2.png"), tag: 1)
        let lib:UITabBarItem = UITabBarItem(title: "図鑑", image: UIImage(named:"book3.png"), tag: 2)
        let calle:UITabBarItem = UITabBarItem(title: "カレンダー", image: UIImage(named:"cale.png"), tag: 3)
        
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
    /*
     Cellが選択された際に呼び出される
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myItems[indexPath.row])")
    }
    
    /*
     Cellの総数を返す.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    /*
     Cellに値を設定する
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
