//
//  Saveimage.swift
//  Pictorial_Time_Machine2
//
//  Created by 稲村　和佳 on 2018/10/08.
//  Copyright © 2018年 稲村　和佳. All rights reserved.
//

import UIKit
import AVFoundation

class Saveimage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  //昼夜のフラグ設定
  var flg_dark: Bool = true
  var flg_evening: Bool = true
  
  //buttomのimage
  var img_save = UIImage()
  var img_return = UIImage()
  let Back_image:UIImage = UIImage(named: "Back.png")!
  let choose_image:UIImage = UIImage(named: "choose.png")!
  let Save_image:UIImage = UIImage(named: "SaveButton.png")!
  
  //星空のimage
  let night_imageS:UIImage = UIImage(named: "S.jpg")!
  let night_image6:UIImage = UIImage(named: "star6.jpg")!
  let night_image5:UIImage = UIImage(named: "star5.jpg")!
  let night_image4:UIImage = UIImage(named: "star4.jpg")!
  let night_image3:UIImage = UIImage(named: "star3.jpg")!
  let night_image2:UIImage = UIImage(named: "star2.jpg")!
  let night_image1:UIImage = UIImage(named: "star1.jpg")!
  
  //確認画面のview
  @IBOutlet weak var img_show: UIImageView!
  
  //buttomの定義
  let return_dark_buttom = UIButton(type: UIButton.ButtonType.system)
  let return_evening_buttom = UIButton(type: UIButton.ButtonType.system)
  let select_buttom = UIButton()
  let backbutton = UIButton()
  let savebutton = UIButton(type: UIButton.ButtonType.system)

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.black
    
    //画像サイズ
    img_show.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-50)
    img_return = img_save
    img_show.image = img_save
    
    // ボタンを押した時に実行するメソッドを指定
    backbutton.addTarget(self, action: #selector(backpage(_:)), for: UIControl.Event.touchUpInside)
    savebutton.addTarget(self, action: #selector(Saveimg(_:)), for: UIControl.Event.touchUpInside)
    select_buttom.addTarget(self, action: #selector(choosePicture), for: UIControl.Event.touchUpInside)
    
    // ラベルを設定する
    backbutton.setImage(Back_image, for: .normal)
    savebutton.setImage(Save_image, for: .normal)
    select_buttom.setImage(choose_image, for: .normal)
    
    // サイズ
    backbutton.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
    savebutton.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
    select_buttom.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    
    // 位置
    backbutton.layer.position = CGPoint(x: 40 , y: self.view.frame.height - 25)
    savebutton.layer.position = CGPoint(x: self.view.frame.width - 40, y:self.view.frame.height - 25)
    select_buttom.layer.position = CGPoint(x: self.view.frame.width*2/3+10, y: self.view.frame.height - 25)
    
    // viewに追加する
    self.view.addSubview(backbutton)
    self.view.addSubview(savebutton)
    self.view.addSubview(select_buttom)
    
    //NightボタンとReturnボタンを切り替える
    change_buttom_dark()
    change_buttom_evening()
  }
  
  // カメラロールから写真を選択する処理
  @objc func choosePicture() {
    // カメラロールが利用可能か？
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      // 写真を選ぶビュー
      let pickerView = UIImagePickerController()
      // 写真の選択元をカメラロールにする
      // 「.camera」にすればカメラを起動できる
      pickerView.sourceType = .photoLibrary
      // デリゲート
      pickerView.delegate = self
      // ビューに表示
      self.present(pickerView, animated: true)
    }
  }
  
  // 写真を選んだ後に呼ばれる処理
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // 選択した写真を取得する
    let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    // 写真を選ぶビューを引っ込める
    self.dismiss(animated: true)
    
    //一度画像を元に戻す
    self.img_save = img_return
    self.img_show.image = img_return
    
    //加工の部分
    return_dark_buttom.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    
    UIGraphicsBeginImageContextWithOptions(self.img_show.image!.size, false, 0.0)
    self.img_show.image!.draw(in:(CGRect(x:0,y:0,width:self.img_show.image!.size.width,height:self.img_show.image!.size.height)))
    self.img_show.image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    UIGraphicsBeginImageContextWithOptions(self.img_save.size, false, 0.0)
    self.img_save.draw(in:(CGRect(x:0,y:0,width:self.img_save.size.width,height:self.img_save.size.height)))
    self.img_save = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: image)
    
    self.img_show.image! = self.img_save
    
    //ボタンが切り替わるようにする
    flg_dark = false
    self.change_buttom_dark()
    
    flg_evening = true
    change_buttom_evening()
    
  }
  
  
  
  func change_buttom_dark(){
    if flg_dark == true{
      title = "🌙"
      return_dark_buttom.layer.borderColor = UIColor.black.cgColor
      return_dark_buttom.backgroundColor = UIColor.black.withAlphaComponent(1)
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
    return_dark_buttom.titleLabel!.font = UIFont.systemFont(ofSize: 30)
    return_dark_buttom.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
    return_dark_buttom.layer.position = CGPoint(x: self.view.frame.width/4+20, y:self.view.frame.height - 25)
    return_dark_buttom.layer.borderWidth = 2
    return_dark_buttom.layer.cornerRadius = 15

    self.view.addSubview(return_dark_buttom)
  }
    
    func change_buttom_evening(){
        if flg_evening == true{
            title = "🌆"
          return_evening_buttom.layer.borderColor = UIColor.black.cgColor
          return_evening_buttom.backgroundColor = UIColor.black.withAlphaComponent(1)
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
        return_evening_buttom.titleLabel!.font = UIFont.systemFont(ofSize: 30)
        return_evening_buttom.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        return_evening_buttom.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 25)
        //return_dark_buttom.backgroundColor = UIColor.black.withAlphaComponent(1)
        return_evening_buttom.layer.borderWidth = 2
        return_evening_buttom.layer.cornerRadius = 15
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
  
  @objc func dark_or_return(_ sender: Any) {
    if flg_dark == true{
      img_save = img_return
      flg_evening = true
      change_buttom_evening()
      return_dark_buttom.layer.borderColor = UIColor.black.cgColor
      return_dark_buttom.backgroundColor = UIColor.white.withAlphaComponent(0.5)
      DispatchQueue.main.async(execute: {
        self.start()
        self.touch_able(able: false)
      })
      DispatchQueue.main.asyncAfter(deadline: .now() + 1
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
             }else if( random == 1 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image1)
             }else if( random == 2 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image2)
             }else if( random == 3 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image3)
             }else if( random == 4 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image4)
             }else if( random == 5 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image5)
             }else if( random == 6 ) {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image6)
             }else {
                self.img_save = OpenCVWrapper.inthedark(from: self.img_save, nightImage: self.night_image3)
             }
            
          self.img_show.image! = self.img_save
          self.flg_dark.toggle()
          self.change_buttom_dark()
          self.touch_able(able: true)
      })
    }else{
      if flg_evening == false{
        flg_evening.toggle()
        change_buttom_evening()
      }
      img_save = img_return
      img_show.image = img_return
      flg_dark.toggle()
      change_buttom_dark()
    }
  }
    
    @objc func evening_or_return(_ sender: Any) {
        if flg_evening == true{
          img_save = img_return
          flg_dark = true
          change_buttom_dark()
          return_evening_buttom.layer.borderColor = UIColor.black.cgColor
          return_evening_buttom.backgroundColor = UIColor.white.withAlphaComponent(0.5)

          DispatchQueue.main.async(execute: {
            self.start()
            self.touch_able(able: false)
          })
          DispatchQueue.main.asyncAfter(deadline: .now() + 1
              , execute: {
                UIGraphicsBeginImageContextWithOptions(self.img_show.image!.size, false, 0.0)
                self.img_show.image!.draw(in:(CGRect(x:0,y:0,width:self.img_show.image!.size.width,height:self.img_show.image!.size.height)))
                self.img_show.image = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                    
                UIGraphicsBeginImageContextWithOptions(self.img_save.size, false, 0.0)
                self.img_save.draw(in:(CGRect(x:0,y:0,width:self.img_save.size.width,height:self.img_save.size.height)))
                self.img_save = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                self.img_save = OpenCVWrapper.intheEvening(from: self.img_save, nightImage: self.night_image1)
                self.img_show.image! = self.img_save
                self.flg_evening.toggle()
                self.change_buttom_evening()
                self.touch_able(able: true)
          })
        }else{
          img_save = img_return
          img_show.image = img_return
          flg_evening.toggle()
          change_buttom_evening()
      }
    }
  
  //indicator
    @objc func start(){
        let sunmoon1 = UIImage(named:"sunmoon1.PNG")!
        let sunmoon2 = UIImage(named:"sunmoon2.PNG")!
        let sunmoon3 = UIImage(named:"sunmoon3.PNG")!
        let sunmoon4 = UIImage(named:"sunmoon4.PNG")!
        
        var imageListArray : Array<UIImage> = []
        
        imageListArray.append(sunmoon1)
        imageListArray.append(sunmoon2)
        imageListArray.append(sunmoon3)
        imageListArray.append(sunmoon4)
        
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        let imageWidth = sunmoon1.size.width/6
        let imageHeight = sunmoon1.size.height/6
        
        let imageView:UIImageView = UIImageView(image:nil)
        // 画像サイズからImageViewの大きさを設定していく
        let rect = CGRect(x:100,
                          y:100,
                          width:imageWidth,
                          height:imageHeight )
        
        imageView.frame = rect
        // 画像が画面中央にくるように位置合わせ
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
      
        self.view.addSubview(imageView)
        // 画像Arrayをアニメーションにセット
        imageView.animationImages = imageListArray
        // 間隔（秒単位）
        imageView.animationDuration = 1.5
        // 繰り返し
        imageView.animationRepeatCount = 1
        // アニメーションを開始
        imageView.startAnimating()
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.3
        imageView.clipsToBounds = true
        self.view.bringSubviewToFront(imageView)
        // アニメーションを終了
        //imageView.stopAnimating()
        
    }

  //buttomの機能ture:on,false:off
  func touch_able(able:Bool){
    return_evening_buttom.isUserInteractionEnabled = able
    return_dark_buttom.isUserInteractionEnabled = able
    select_buttom.isUserInteractionEnabled = able
    savebutton.isUserInteractionEnabled = able
    backbutton.isUserInteractionEnabled = able
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
