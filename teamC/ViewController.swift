//
//  ViewController.swift
//  teamC
//
//  Created by 河野佑亮 on 2017/12/07.
//  Copyright © 2017年 河野佑亮. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 背景
        self.view.backgroundColor = UIColor.white
        //ラベル
        let label = UILabel()
        label.text = "アプリ名"
        label.font = UIFont(name: "HiraMinProN-W3", size: 80)
        label.sizeToFit()
        label.center = CGPoint(x: 200, y: 100) // UILabelの中央座標を (200, 100) にする
        label.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.width/3)
        self.view.addSubview(label)
        
        //ボタン
        let nextbutton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 120, height: 50))
       // ボタンの位置を指定する.
        nextbutton.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.bounds.height-200)
        nextbutton.backgroundColor = UIColor.gray //色
        nextbutton.layer.masksToBounds = true
        nextbutton.setTitle("はじめる", for: .normal)// ボタンを押していないときの設定
        nextbutton.setTitleColor(UIColor.white, for: .normal)
        nextbutton.layer.cornerRadius = 20.0
        nextbutton.addTarget(self, action: #selector(ViewController.goNext(_:)), for: .touchUpInside)
        //nextbutton.sizeToFit()
        self.view.addSubview(nextbutton)
    }
    
    @objc func goNext(_ sender: UIButton) {// selectorで呼び出す場合Swift4からは「@objc」をつける。
        let nextvc = SecondViewController() // 遷移するViewを定義する.
        nextvc.modalTransitionStyle = .crossDissolve
        self.present(nextvc, animated: true, completion: nil)// Viewの移動する.
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

