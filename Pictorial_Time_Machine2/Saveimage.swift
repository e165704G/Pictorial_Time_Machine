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
  var flg: Bool = true
  let Back_image:UIImage = UIImage(named: "Back.png")!
  let night_image:UIImage = UIImage(named: "star3.jpg")!
  
  //@IBOutlet weak var gaso: UILabel!
  @IBOutlet weak var img_show: UIImageView!
  
  let return_dark_buttom = UIButton(type: UIButton.ButtonType.system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.cyan
    
    //画像サイズ
    img_show.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
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
    savebutton.setTitle("保存", for: UIControl.State.normal)
    
    // サイズ
    backbutton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    savebutton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    
    // 位置
    backbutton.layer.position = CGPoint(x: self.view.frame.width - 30 , y: 45)
    savebutton.layer.position = CGPoint(x: self.view.frame.width - 45, y:self.view.frame.height - 45)
    
    // 背景色
    backbutton.backgroundColor = UIColor.white
    savebutton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    // 枠の太さ
    
    // 枠の色
    savebutton.layer.borderColor = UIColor.white.cgColor
    
    // 枠に丸み
    backbutton.layer.cornerRadius = 25
    savebutton.layer.cornerRadius = 25
    
    // viewに追加する
    self.view.addSubview(backbutton)
    self.view.addSubview(savebutton)
    
    //NightボタンとReturnボタンを切り替える
    change_buttom()
  }
  
  func change_buttom(){
    if flg == true{
      title = "Night🌙"
    }else{
      title = "Return☀️"
    }
    /* buttomの各設定(上から順に)
     ボタンを押した時に実行するメソッドを指定,タイトル,タイトルの色,タイトルのフォント,
     サイズ,位置,背景色,枠の太さ,枠の色,枠の丸み,viewに追加
     */
    self.return_dark_buttom.addTarget(self, action: #selector(dark_or_return(_:)), for: UIControl.Event.touchUpInside)
    return_dark_buttom.setTitle(title, for: UIControl.State.normal)
    return_dark_buttom.setTitleColor(UIColor.white, for: UIControl.State.normal)
    return_dark_buttom.titleLabel!.font = UIFont.systemFont(ofSize: 25)
    return_dark_buttom.frame = CGRect(x: 0, y: 0, width: 130, height: 80)
    return_dark_buttom.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 45)
    return_dark_buttom.backgroundColor = UIColor.black.withAlphaComponent(1)
    return_dark_buttom.layer.borderWidth = 2
    return_dark_buttom.layer.borderColor = UIColor.white.cgColor
    return_dark_buttom.layer.cornerRadius = 25
    self.view.addSubview(return_dark_buttom)
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
    if flg == true{
      UIGraphicsBeginImageContextWithOptions(img_show.image!.size, false, 0.0)
      img_show.image!.draw(in:(CGRect(x:0,y:0,width:img_show.image!.size.width,height:img_show.image!.size.height)))
      img_show.image = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
    
      UIGraphicsBeginImageContextWithOptions(img_save.size, false, 0.0)
      img_save.draw(in:(CGRect(x:0,y:0,width:img_save.size.width,height:img_save.size.height)))
      img_save = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
    
      img_save = OpenCVWrapper.inthedark(from: img_save, nightImage: night_image)
      //image3 = OpenCVWrapper.inthedark(from: image3)
      img_show.image! = img_save
    }else{
      img_save = img_return
      img_show.image = img_return
    }
    flg.toggle()
    change_buttom()
  }
  
}
