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
  var img_save = UIImage()
  var img_return = UIImage()
  var flg_dark: Bool = true
  var flg_evening: Bool = true
  let Back_image:UIImage = UIImage(named: "Back.png")!
    let night_imageS:UIImage = UIImage(named: "S.jpg")!
    let night_image6:UIImage = UIImage(named: "star6.jpg")!
    let night_image5:UIImage = UIImage(named: "star5.jpg")!
    let night_image4:UIImage = UIImage(named: "star4.jpg")!
    let night_image3:UIImage = UIImage(named: "star3.jpg")!
    let night_image2:UIImage = UIImage(named: "star2.jpg")!
    let night_image1:UIImage = UIImage(named: "star1.jpg")!
  let Save_image:UIImage = UIImage(named: "SaveButton.png")!
    
  let indicator = UIActivityIndicatorView()
  
  //@IBOutlet weak var gaso: UILabel!
  @IBOutlet weak var img_show: UIImageView!
  
  let return_dark_buttom = UIButton(type: UIButton.ButtonType.system)
  let return_evening_buttom = UIButton(type: UIButton.ButtonType.system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.black
    
    //画像サイズ
    img_show.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-50)
    img_return = img_save
    img_show.image = img_save
    
    // Do any additional setup after loading the view.
    //let darkbutton = UIButton(type: UIButton.ButtonType.system)
    let backbutton = UIButton()
    let savebutton = UIButton(type: UIButton.ButtonType.system)
    
    // ボタンを押した時に実行するメソッドを指定
    backbutton.addTarget(self, action: #selector(backpage(_:)), for: UIControl.Event.touchUpInside)
    savebutton.addTarget(self, action: #selector(Saveimg(_:)), for: UIControl.Event.touchUpInside)
    
    // ラベルを設定する
    backbutton.setImage(Back_image, for: .normal)
    savebutton.setImage(Save_image, for: .normal)
    
    // サイズ
    backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    savebutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    
    // 位置
    backbutton.layer.position = CGPoint(x: 40 , y: self.view.frame.height - 20)
    savebutton.layer.position = CGPoint(x: self.view.frame.width - 45, y:self.view.frame.height - 20)
    
    // 背景色
    //backbutton.backgroundColor = UIColor.white
    //savebutton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    // 枠の太さ
    
    // 枠の色
    //savebutton.layer.borderColor = UIColor.white.cgColor
    
    // 枠に丸み
    //backbutton.layer.cornerRadius = 25
    //savebutton.layer.cornerRadius = 25
    
    // viewに追加する
    self.view.addSubview(backbutton)
    self.view.addSubview(savebutton)
    
    //NightボタンとReturnボタンを切り替える
    change_buttom_dark()
    change_buttom_evening()
    
    //indicatorの設定
    // UIActivityIndicatorView のスタイルをテンプレートから選択
    indicator.style = .whiteLarge
    // 表示位置
    indicator.center = self.view.center
    // 色の設定
    indicator.color = UIColor.black
    // アニメーション停止と同時に隠す設定
    indicator.hidesWhenStopped = true
    // 画面に追加
    self.view.addSubview(indicator)
    // 最前面に移動
    self.view.bringSubviewToFront(indicator)
  }
  
  func change_buttom_dark(){
    if flg_dark == true{
      title = "🌙"
    }else{
      title = "☀️"
    }
    /* buttomの各設定(上から順に)
     ボタンを押した時に実行するメソッドを指定,タイトル,タイトルの色,タイトルのフォント,
     サイズ,位置,背景色,枠の太さ,枠の色,枠の丸み,viewに追加
     */
    self.return_dark_buttom.addTarget(self, action: #selector(dark_or_return(_:)), for: UIControl.Event.touchUpInside)
    return_dark_buttom.setTitle(title, for: UIControl.State.normal)
    return_dark_buttom.setTitleColor(UIColor.white, for: UIControl.State.normal)
    return_dark_buttom.titleLabel!.font = UIFont.systemFont(ofSize: 35)
    return_dark_buttom.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    return_dark_buttom.layer.position = CGPoint(x: self.view.frame.width/4+20, y:self.view.frame.height - 20)
    //return_dark_buttom.backgroundColor = UIColor.black.withAlphaComponent(1)
    //return_dark_buttom.layer.borderWidth = 2
    //return_dark_buttom.layer.borderColor = UIColor.white.cgColor
    //return_dark_buttom.layer.cornerRadius = 25
    self.view.addSubview(return_dark_buttom)
  }
    
    func change_buttom_evening(){
        if flg_evening == true{
            title = "🌆"
        }else{
            title = "☀️"
        }
        /* buttomの各設定(上から順に)
         ボタンを押した時に実行するメソッドを指定,タイトル,タイトルの色,タイトルのフォント,
         サイズ,位置,背景色,枠の太さ,枠の色,枠の丸み,viewに追加
         */
        self.return_evening_buttom.addTarget(self, action: #selector(evening_or_return(_:)), for: UIControl.Event.touchUpInside)
        return_evening_buttom.setTitle(title, for: UIControl.State.normal)
        return_evening_buttom.setTitleColor(UIColor.white, for: UIControl.State.normal)
        return_evening_buttom.titleLabel!.font = UIFont.systemFont(ofSize: 35)
        return_evening_buttom.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return_evening_buttom.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 20)
        //return_dark_buttom.backgroundColor = UIColor.black.withAlphaComponent(1)
        //return_dark_buttom.layer.borderWidth = 2
        //return_dark_buttom.layer.borderColor = UIColor.white.cgColor
        //return_dark_buttom.layer.cornerRadius = 25
        self.view.addSubview(return_evening_buttom)
    }
  
  @objc func Saveimg(_ sender: UITapGestureRecognizer) {
    UIImageWriteToSavedPhotosAlbum(img_save, self, #selector(self.showResultOfSaveImage(_:didFinishSavingWithError:contextInfo:)), nil)
    //gaso.text = OpenCVWrapper.openCVGasoString(image3)
    
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
  
  @objc func dark_or_return(_ sender: Any) {
    if flg_dark == true{
        return_evening_buttom.isHidden = true
      DispatchQueue.main.async(execute: {
        self.indicator.startAnimating()
      })
      DispatchQueue.main.asyncAfter(deadline: .now() + 3
        , execute: {
          UIGraphicsBeginImageContextWithOptions(self.img_show.image!.size, false, 0.0)
          self.img_show.image!.draw(in:(CGRect(x:0,y:0,width:self.img_show.image!.size.width,height:self.img_show.image!.size.height)))
          self.img_show.image = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
    
          UIGraphicsBeginImageContextWithOptions(self.img_save.size, false, 0.0)
          self.img_save.draw(in:(CGRect(x:0,y:0,width:self.img_save.size.width,height:self.img_save.size.height)))
          self.img_save = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
    
            
            //ランダムで画像お入れる
            let random = arc4random() % 6
             
             if ( random == 0 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_imageS)
             self.img_show.image! = self.img_save
             
             }else if( random == 1 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image1)
             self.img_show.image! = self.img_save
             }else if( random == 2 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image2)
             self.img_show.image! = self.img_save
             }else if( random == 3 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image3)
             self.img_show.image! = self.img_save
             }else if( random == 4 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image4)
             self.img_show.image! = self.img_save
             }else if( random == 5 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image5)
             self.img_show.image! = self.img_save
             }else if( random == 6 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image6)
             self.img_show.image! = self.img_save
             }else {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image3)
             self.img_show.image! = self.img_save
             }
            
          //self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image)
          //image3 = OpenCVWrapper.inthedark(from: image3)
          self.img_show.image! = self.img_save
          self.indicator.stopAnimating()
          self.flg_dark.toggle()
            self.change_buttom_dark()
      })
    }else{
      return_evening_buttom.isHidden = false
      img_save = img_return
      img_show.image = img_return
      flg_dark.toggle()
        change_buttom_dark()
    }
  }
    
    @objc func evening_or_return(_ sender: Any) {
        if flg_evening == true{
            return_dark_buttom.isHidden = true
            DispatchQueue.main.async(execute: {
                self.indicator.startAnimating()
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 3
                , execute: {
                    UIGraphicsBeginImageContextWithOptions(self.img_show.image!.size, false, 0.0)
                    self.img_show.image!.draw(in:(CGRect(x:0,y:0,width:self.img_show.image!.size.width,height:self.img_show.image!.size.height)))
                    self.img_show.image = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()
                    
                    UIGraphicsBeginImageContextWithOptions(self.img_save.size, false, 0.0)
                    self.img_save.draw(in:(CGRect(x:0,y:0,width:self.img_save.size.width,height:self.img_save.size.height)))
                    self.img_save = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()
                    
                    
                    //ランダムで画像お入れる
                    let random = arc4random() % 6
                    
                    if ( random == 0 ) {
                        self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_imageS)
                        self.img_show.image! = self.img_save
                        
                    }else if( random == 1 ) {
                        self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_image1)
                        self.img_show.image! = self.img_save
                    }else if( random == 2 ) {
                        self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_image2)
                        self.img_show.image! = self.img_save
                    }else if( random == 3 ) {
                        self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_image3)
                        self.img_show.image! = self.img_save
                    }else if( random == 4 ) {
                        self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_image4)
                        self.img_show.image! = self.img_save
                    }else if( random == 5 ) {
                        self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_image5)
                        self.img_show.image! = self.img_save
                    }else if( random == 6 ) {
                        self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_image6)
                        self.img_show.image! = self.img_save
                    }else {
                        self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_image3)
                        self.img_show.image! = self.img_save
                    }
                    
                    //self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image)
                    //image3 = OpenCVWrapper.inthedark(from: image3)
                    self.img_show.image! = self.img_save
                    self.indicator.stopAnimating()
                    self.flg_evening.toggle()
                    self.change_buttom_evening()
            })
        }else{
            return_dark_buttom.isHidden = false
            img_save = img_return
            img_show.image = img_return
            flg_evening.toggle()
            change_buttom_evening()
        }
    }
  
}
