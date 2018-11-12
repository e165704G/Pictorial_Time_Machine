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
    
   
    @IBOutlet weak var gaso: UILabel!
    @IBOutlet weak var image1: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.cyan
        
        //画像サイズ
        image1.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        image1.image = image3
        // Do any additional setup after loading the view.
        
        let graybutton = UIButton(type: UIButton.ButtonType.system)
        let backbutton = UIButton(type: UIButton.ButtonType.system)
        let savebutton = UIButton(type: UIButton.ButtonType.system)
        
        // ボタンを押した時に実行するメソッドを指定
        graybutton.addTarget(self, action: #selector(inthedark(_:)), for: UIControl.Event.touchUpInside)
        backbutton.addTarget(self, action: #selector(backpage(_:)), for: UIControl.Event.touchUpInside)
        savebutton.addTarget(self, action: #selector(Saveimg(_:)), for: UIControl.Event.touchUpInside)
        
        // ラベルを設定する
        graybutton.setTitle("夜にしちゃうぞ☆", for: UIControl.State.normal)
        backbutton.setTitle("Back", for: UIControl.State.normal)
        savebutton.setTitle("保存", for: UIControl.State.normal)
        
        // サイズ
        graybutton.frame = CGRect(x: 0, y: 0, width: 130, height: 80)
        backbutton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        savebutton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        // 位置
        graybutton.layer.position = CGPoint(x: 70, y:self.view.frame.height - 45)
        backbutton.layer.position = CGPoint(x: 185 , y:self.view.frame.height - 45)
        savebutton.layer.position = CGPoint(x: self.view.frame.width - 45, y:self.view.frame.height - 45)
        
        // 背景色
        graybutton.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.6, alpha: 1)
        backbutton.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.6, alpha: 1)
        savebutton.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.6, alpha: 1)
        
        // 枠の太さ
        graybutton.layer.borderWidth = 0.5
        backbutton.layer.borderWidth = 0.5
        savebutton.layer.borderWidth = 0.5
        
        // 枠の色
        graybutton.layer.borderColor = UIColor(red: 0.3, green: 0.6, blue: 0.5, alpha: 1).cgColor
        backbutton.layer.borderColor = UIColor(red: 0.3, green: 0.6, blue: 0.5, alpha: 1).cgColor
        savebutton.layer.borderColor = UIColor(red: 0.3, green: 0.6, blue: 0.5, alpha: 1).cgColor
        
        // 枠に丸み
        graybutton.layer.cornerRadius = 25
        backbutton.layer.cornerRadius = 25
        savebutton.layer.cornerRadius = 25
        
        // viewに追加する
        self.view.addSubview(graybutton)
        self.view.addSubview(backbutton)
        self.view.addSubview(savebutton)
        
        
        
    }
    
    @IBAction func Saveimg(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image3, self, nil, nil)
        //gaso.text = OpenCVWrapper.openCVGasoString(image3)
    }
    
    //ページ戻
    @IBAction func backpage(_ sender: Any) {
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
    @IBAction func inthedark(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(image1.image!.size, false, 0.0)
        image1.image!.draw(in:(CGRect(x:0,y:0,width:image1.image!.size.width,height:image1.image!.size.height)))
        image1.image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        
        UIGraphicsBeginImageContextWithOptions(image3.size, false, 0.0)
        image3.draw(in:(CGRect(x:0,y:0,width:image3.size.width,height:image3.size.height)))
        image3 = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        image1.image = OpenCVWrapper.inthedark(from: image1.image!)
        //image3 = OpenCVWrapper.inthedark(from: image3)
        image3 = image1.image!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
