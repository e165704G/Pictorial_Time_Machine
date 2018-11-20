//
//  ViewController.swift
//  Pictorial_Time_Machine2
//
//  Created by 稲村　和佳 on 2018/10/08.
//  Copyright © 2018年 稲村　和佳. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
  var img7 = UIImage(named:"iwamotoyama_ee-1200x880")!
  var image2 = UIImage()
  let shutter_image:UIImage = UIImage(named: "shutter.png")!
  
  @IBOutlet weak var cameraView: UIView!
  
  var captureSesssion: AVCaptureSession!
  var stillImageOutput: AVCapturePhotoOutput?
  var previewLayer: AVCaptureVideoPreviewLayer?
  
  let confirm_button = UIButton()
  var take = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let shutter_button = UIButton()
      
    //シャッターボタンのimageを設定
    shutter_button.setImage(shutter_image, for: .normal)
        
    // ボタンを押した時に実行するメソッドを指定
    confirm_button.addTarget(self, action: #selector(saveImage(_:)), for: UIControl.Event.touchUpInside)
    shutter_button.addTarget(self, action: #selector(cameraAction(_:)), for: UIControl.Event.touchUpInside)
      
    // サイズ
    confirm_button.frame = CGRect(x: 0, y: 0, width: 90*self.view.frame.width/self.view.frame.height, height: 90)
    shutter_button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
    
    // 位置
    confirm_button.layer.position = CGPoint(x: self.view.frame.width/6, y:self.view.frame.height - 50)
    shutter_button.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 45)
    // 背景色
    confirm_button.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
      
    // 枠の太さ
    confirm_button.layer.borderWidth = 1.0
      
    // 枠の色
    confirm_button.layer.borderColor = UIColor.white.cgColor
      
    // viewに追加する
    self.view.addSubview(confirm_button)
    self.view.addSubview(shutter_button)
        
    self.view.backgroundColor = UIColor.cyan
        
    //opencvの基礎　バージョンを表示
    //openCVversionLabel.text = OpenCVWrapper.openCVVersionString()
        
        
    captureSesssion = AVCaptureSession()
    stillImageOutput = AVCapturePhotoOutput()
        
    // 解像度の設定
    captureSesssion.sessionPreset = AVCaptureSession.Preset.hd1920x1080
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    
    do {
      let input = try AVCaptureDeviceInput(device: device!)
      
      // 入力
      if (captureSesssion.canAddInput(input)) {
        captureSesssion.addInput(input)
        // 出力
        if (captureSesssion.canAddOutput(stillImageOutput!)) {
          // カメラ起動
          captureSesssion.addOutput(stillImageOutput!)
          captureSesssion.startRunning()
                    
          // アスペクト比、カメラの向き(縦)
          previewLayer = AVCaptureVideoPreviewLayer(session: captureSesssion)
          previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect // アスペクトフィット
          previewLayer?.connection!.videoOrientation = AVCaptureVideoOrientation.portrait
                    
          cameraView.layer.addSublayer(previewLayer!)
                    
          // ビューのサイズの調整
          cameraView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
          previewLayer?.position = CGPoint(x: self.cameraView.frame.width / 2, y: self.cameraView.frame.height / 2)
          previewLayer?.bounds = cameraView.frame
        }
      }
    }catch{
      print(error)
    }
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  @objc func cameraAction(_ sender: AnyObject) {
    // カメラの設定
    let settingsForMonitoring = AVCapturePhotoSettings()
    settingsForMonitoring.flashMode = .auto
    settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
    settingsForMonitoring.isHighResolutionPhotoEnabled = false
        
    // 撮影
    stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self)
  }
  
  func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    // JPEG形式で画像データを取得
    let imageData = photo.fileDataRepresentation()
            
    image2 = UIImage(data: imageData!)!
          
    confirm_button.setImage(image2, for: .normal)
          
    take = true
    
    //button1.imageView?.contentMode = .scaleAspectFit
    //self.view.addSubview(button1)
  }
  
  @objc func saveImage(_ sender: AnyObject ) {
    if take != false{
      goToNextPage()
    }else{//写真を撮っていない時の処理
      let alert = UIAlertController(title: "写真がありません", message: "Let's take a picture!", preferredStyle: .alert)
      // OKボタンを追加
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          
      // UIAlertController を表示
      self.present(alert, animated: true, completion: nil)
    }
  }
  func goToNextPage(){
    //指定したIDのSegueを初期化する。同時にパラメータを渡すことができる
    self.performSegue(withIdentifier: "mySegue", sender:image2)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "mySegue" {
      let secondViewController = segue.destination as! Saveimage
      secondViewController.image3 = image2
    }
  }
  @IBAction func backToTop(segue: UIStoryboardSegue) {}
    
    override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
  
}

