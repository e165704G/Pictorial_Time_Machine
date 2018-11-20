//
//  Saveimage.swift
//  Pictorial_Time_Machine2
//
//  Created by 稲村　和佳 on 2018/10/08.
//  Copyright © 2018年 稲村　和佳. All rights reserved.
//

import UIKit
import AVFoundation

class Saveimage: UIViewController {
  
  var img7 = UIImage(named:"iwamotoyama_ee-1200x880")!
  var image3 = UIImage()
  var image4 = UIImage()
  var flg: Bool = true
  let Back_image:UIImage = UIImage(named: "Back.png")!
  let night_image:UIImage = UIImage(named: "star3.jpg")!
  
  //@IBOutlet weak var gaso: UILabel!
  @IBOutlet weak var image1: UIImageView!
  
    let darkbutton = UIButton(type: UIButton.ButtonType.system)
    let returnbutton = UIButton(type: UIButton.ButtonType.system)
    let backbutton = UIButton()
    let savebutton = UIButton(type: UIButton.ButtonType.system)
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.cyan
    
    setView()
    viewsize()
    
  }
    
    func setView(){
        //画像サイズ
        image1.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        image4 = image3
        image1.image = image3
        
        // Do any additional setup after loading the view.
        //let darkbutton = UIButton(type: UIButton.ButtonType.system)
        
        
        // ボタンを押した時に実行するメソッドを指定
        darkbutton.addTarget(self, action: #selector(intheDark(_:)), for: UIControl.Event.touchUpInside)
        backbutton.addTarget(self, action: #selector(backpage(_:)), for: UIControl.Event.touchUpInside)
        savebutton.addTarget(self, action: #selector(Saveimg(_:)), for: UIControl.Event.touchUpInside)
        returnbutton.addTarget(self, action: #selector(returntheDark(_:)), for: UIControl.Event.touchUpInside)
        // ラベルを設定する
        darkbutton.setTitle("Night🌙", for: UIControl.State.normal)
        darkbutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        darkbutton.titleLabel!.font = UIFont.systemFont(ofSize: 25)
        
        backbutton.setImage(Back_image, for: .normal)
        savebutton.setTitle("保存", for: UIControl.State.normal)
        
        returnbutton.setTitle("Return☀️", for: UIControl.State.normal)
        returnbutton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        returnbutton.titleLabel!.font = UIFont.systemFont(ofSize: 25)
        // サイズ
        darkbutton.frame = CGRect(x: 0, y: 0, width: 130, height: 80)
        backbutton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        savebutton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        returnbutton.frame = CGRect(x: 0, y: 0, width: 130, height: 80)
        // 位置
        darkbutton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 45)
        backbutton.layer.position = CGPoint(x: self.view.frame.width - 30 , y: 45)
        savebutton.layer.position = CGPoint(x: self.view.frame.width - 45, y:self.view.frame.height - 45)
        returnbutton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 45)
        // 背景色
        darkbutton.backgroundColor = UIColor.black.withAlphaComponent(1)
        backbutton.backgroundColor = UIColor.white
        savebutton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        returnbutton.backgroundColor = UIColor.black.withAlphaComponent(1)
        // 枠の太さ
        darkbutton.layer.borderWidth = 2
        //backbutton.layer.borderWidth = 0.5
        //savebutton.layer.borderWidth = 0.5
        returnbutton.layer.borderWidth = 2
        // 枠の色
        darkbutton.layer.borderColor = UIColor.white.cgColor
        //backbutton.layer.borderColor = UIColor.white.cgColor
        savebutton.layer.borderColor = UIColor.white.cgColor
        returnbutton.layer.borderColor = UIColor.white.cgColor
        // 枠に丸み
        darkbutton.layer.cornerRadius = 25
        backbutton.layer.cornerRadius = 25
        savebutton.layer.cornerRadius = 25
        returnbutton.layer.cornerRadius = 25
        // viewに追加する
        
        self.view.addSubview(backbutton)
        self.view.addSubview(savebutton)
        
        if (flg == true){
            self.view.addSubview(darkbutton)
        }
        
    }
    
    func viewsize(){
        UIGraphicsBeginImageContextWithOptions(image1.image!.size, false, 0.0)
        image1.image!.draw(in:(CGRect(x:0,y:0,width:image1.image!.size.width,height:image1.image!.size.height)))
        image1.image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
  
  @objc func Saveimg(_ sender: UITapGestureRecognizer) {
      UIImageWriteToSavedPhotosAlbum(image3, self, #selector(self.showResultOfSaveImage(_:didFinishSavingWithError:contextInfo:)), nil)
      //gaso.text = OpenCVWrapper.openCVGasoString(image3)
    
  }
    
    //スマホの画面回転
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var sx = 0
        var sy = 0
        var w = 0
        var h = 0
        
        // ここに回転時の処理
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            //do something
            sx = 0
            sy = 0
            w = Int(UIScreen.main.bounds.size.width)
            h = Int(UIScreen.main.bounds.size.height)
            break
            
        case .portraitUpsideDown:
            //do something
            sx = Int(UIScreen.main.bounds.size.width)
            sy = Int(UIScreen.main.bounds.size.height)
            w = 0
            h = 0
            break
            
        case .landscapeLeft:
            //do something
            sx = 0
            sy = 0
            w = Int(UIScreen.main.bounds.size.height)
            h = Int(UIScreen.main.bounds.size.width)
            break
            
        case .landscapeRight:
            //do something
            sx = Int(UIScreen.main.bounds.size.height)
            sy = Int(UIScreen.main.bounds.size.width)
            w = 0
            h = 0
            break
        case .unknown:
            //default
            break
        }
        
        image1.frame = CGRect(x: sx, y: sy, width: w, height: h)
        image4 = image3
        image1.image = image3
        
        setView()
        viewsize()
    }
  
  // 保存を試みた結果をダイアログで表示
  @objc func showResultOfSaveImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer){
    var title = "保存完了"
    var message = "カメラロールに保存しました"
    
    if error != nil {
      title = "エラー"
      message = "保存に失敗しました"
    }
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    // OKボタンを追加
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
    // UIAlertController を表示
    self.present(alert, animated: true, completion: nil)
    
  }
  
  //ページ戻
  @objc func backpage(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
    
  }
    
    
    /*@IBAction func toGrayScaleButtonTouched(_ sender: Any) {
        
        
        UIGraphicsBeginImageContextWithOptions(image1.image!.size, false, 0.0)
        image1.image!.draw(in:(CGRect(x:0,y:0,width:image1.image!.size.width,height:image1.image!.size.height)))
        image1.image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        image1.image = OpenCVWrapper.makeGray(from: image1.image!)
        image3 = OpenCVWrapper.makeGray(from: image1.image!)
        
    }*/
    
    
    /*@IBAction func getColor(_ sender: Any) {
        //画像の向き固定
        UIGraphicsBeginImageContextWithOptions(image1.image!.size, false, 0.0)
        image1.image!.draw(in:(CGRect(x:0,y:0,width:image1.image!.size.width,height:image1.image!.size.height)))
        image1.image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        image1.image = OpenCVWrapper.whiteGet(from: image1.image!)
        image3 = OpenCVWrapper.whiteGet(from: image1.image!)
    }
    
    
    */
  
  @objc func intheDark(_ sender: Any) {
    UIGraphicsBeginImageContextWithOptions(image1.image!.size, false, 0.0)
    image1.image!.draw(in:(CGRect(x:0,y:0,width:image1.image!.size.width,height:image1.image!.size.height)))
    image1.image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    UIGraphicsBeginImageContextWithOptions(image3.size, false, 0.0)
    image3.draw(in:(CGRect(x:0,y:0,width:image3.size.width,height:image3.size.height)))
    image3 = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    image3 = OpenCVWrapper.inthedark(from: image3, nightImage: night_image)
    //image3 = OpenCVWrapper.inthedark(from: image3)
    image1.image! = image3
    
    flg.toggle()
    if (flg == false){
        self.view.addSubview(returnbutton)
        }
    }
    
    @objc func returntheDark(_ sender: Any) {
        image3 = image4
        image1.image = image4
        
        
        flg.toggle()
        if (flg == true){
            self.view.addSubview(darkbutton)
    }
    }
    
  }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
