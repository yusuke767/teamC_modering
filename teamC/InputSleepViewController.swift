//
//  InputSleepViewController.swift
//  teamC
//
//  Created by Kai Uehara on 2018/01/10.
//  Copyright © 2018年 河野佑亮. All rights reserved.
//

import UIKit

class InputSleepViewController: UIViewController, UITextFieldDelegate {

    var input = UITextField() //睡眠時間を入力してもらうテキストフィールド
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        //タイトルのラベル
        let title = UILabel()
        title.text = "本日の睡眠時間"
        title.font = UIFont(name: "HiraMinProN-W3", size: 30)
        title.sizeToFit()
        title.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/3)
        self.view.addSubview(title)
        
        //時間って書いてあるラベル
        let jikan = UILabel()
        jikan.text = "時間"
        jikan.font = UIFont(name: "HiraMinProN-W3", size: 30)
        jikan.sizeToFit()
        jikan.layer.position = CGPoint(x: self.view.frame.width/2+(jikan.frame.width/2), y: self.view.frame.height/3+50)
        self.view.addSubview(jikan)
        
        //睡眠時間を入力してもらうテキストフィールド
        input.font = jikan.font;
        // テキストを右寄せ
        input.textAlignment = NSTextAlignment.right
        input.sizeToFit()
        input.frame = CGRect(x:0, y:0, width: 50, height: input.frame.height);
        input.text = ""
        input.delegate = self
        input.borderStyle = UITextBorderStyle.roundedRect
        input.keyboardType = UIKeyboardType.numberPad
        input.becomeFirstResponder()
        input.layer.position = CGPoint(x: self.view.frame.width/2-(input.frame.width/2), y: self.view.frame.height/3+50)
        self.view.addSubview(input)
        
        //送信ボタン
        let submit = UIButton()
        submit.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        submit.setTitle("送信", for: .normal)
        submit.setTitleColor(UIColor.blue, for: .normal)
        submit.sizeToFit()
        submit.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/3+100)
        self.view.addSubview(submit)
        //ボタンを押された時の処理
        submit.addTarget(self,
                         action: #selector(InputSleepViewController.buttonTapped(sender:)),
                         for: .touchUpInside)
    }
    
    //入力の時に2文字制限をかける
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 文字数最大を決める.
        let maxLength: Int = 2
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let str = textField.text! + string
        
        // 文字数がmaxLength以下ならtrueを返す.
        if str.count <= maxLength {
            return true
        }
        print("2文字を超えています")
        return false
    }
    
    //ボタンを押された時の処理
    @objc func buttonTapped(sender : AnyObject){
        if (Int(input.text!) == nil){ //型変換失敗
            errorOccurred()
        }
        else { //型変換成功
            let input_int = Int(input.text!)!
            if (input_int < 0 || input_int > 24){ //数字がおかしい
                errorOccurred()
            }
            else { //エラーなし
                let save_input = UserDefaults.standard //これに睡眠時間がIntで保存される
                let save_day = UserDefaults.standard //保存した日時を保存
                let now = Date() // 現在日時の取得
                save_input.set(input_int, forKey: "int")
                save_day.set(now, forKey: "date")
                
                print(now)
                toNextVC()
            }
        }
    }
    
    //エラーが起きた時
    func errorOccurred(){
        let errorlabel = UILabel()
        errorlabel.text = "※0~24の整数を入力してね"
        errorlabel.font = UIFont(name: "HiraMinProN-W3", size: 15)
        errorlabel.textColor = UIColor.red
        errorlabel.sizeToFit()
        errorlabel.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/3+150)
        self.view.addSubview(errorlabel)
    }
    
    //次のViewControllerへ
    func toNextVC(){
        let nextvc = SecondViewController() //遷移するViewを定義する
        nextvc.modalTransitionStyle = .crossDissolve
        self.present(nextvc, animated: true, completion: nil) //Viewの移動する
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
