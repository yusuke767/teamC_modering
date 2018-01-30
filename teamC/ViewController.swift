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
    var audioPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 背景
        self.view.backgroundColor = UIColor.black
        setBackgroundImage()
        //BGM
        setSystemSound("hyposomniac_nightmere")
        //ロゴ
        setLogo()
        let screenbutton: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        // 画面全体をボタンに
        screenbutton.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
        screenbutton.backgroundColor = UIColor.clear //色
        screenbutton.layer.masksToBounds = true// ボタンを押していないときの設定
        screenbutton.addTarget(self, action: #selector(ViewController.goNext(_:)), for: .touchUpInside)
        //nextbutton.sizeToFit()
        self.view.addSubview(screenbutton)
        
        //文字表示
        let bWidth: CGFloat = self.view.bounds.width
        let bHeight: CGFloat = 100
        // 配置する座標を定義
        let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
        let posY: CGFloat = self.view.bounds.height*4/5 - bHeight/2
        let nexttext: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        //テキストを白に
        nexttext.textColor = UIColor.white
        // UILabelに文字を代入.
        nexttext.text = "Touch The Screen"
        //フォント
        nexttext.font = UIFont(name: "Copperplate-Light", size: 40)
        // Textを中央寄せにする.
        nexttext.textAlignment = NSTextAlignment.center
        // ViewにLabelを追加.
        self.view.addSubview(nexttext)

        
    }
    
    func setSystemSound(_ BGM:String?) {
        // サウンドデータの読み込み。ファイル名は引数。拡張子は"mp3"
        let audioPath = NSURL(fileURLWithPath: Bundle.main.path(forResource: BGM, ofType: "mp3")!)
        
        // tryでエラー処理
        do {
            // AVAudioPlayerを作成。もし何かの事情で作成できなかったらエラーがthrowされる
            audioPlayer = try AVAudioPlayer(contentsOf: audioPath as URL)
            
            audioPlayer.numberOfLoops = -1   // ループ再生する
            audioPlayer.prepareToPlay()      // 即時再生させる
            
            // イベントを通知したいUIViewControllerをdelegateに登録
            // delegateの登録するならAVAudioPlayerDelegateプロトコルの継承が必要
            audioPlayer.delegate = self as? AVAudioPlayerDelegate
            
            // これで再生
            audioPlayer.play()
        }
            // playerを作成した時にエラーがthrowされたらこっち来る
        catch {
            print("AVAudioPlayer error")
        }
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
    
    //背景画像設定
    func setBackgroundImage() {
        var imageView:UIImageView!
        // インスタンスの生成
        let image = UIImage(named:"titleback.png")!
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
    //タイトルロゴ表示設定
    func setLogo() {
        var imageView:UIImageView!
        let image = UIImage(named:"titlelogo.png")!
        imageView = UIImageView(image:image)
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        let scale:CGFloat = screenHeight / height
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        imageView.frame = rect;
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        self.view.contentMode = UIViewContentMode.topLeft
        self.view.addSubview(imageView)
    }
    


}

