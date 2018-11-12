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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = UIButton(type: UIButton.ButtonType.system)
        let shutter_button = UIButton()
      
        //シャッターボタンのimageを設定
        shutter_button.setImage(shutter_image, for: .normal)
        
        // ボタンを押した時に実行するメソッドを指定
        button1.addTarget(self, action: #selector(saveImage(_:)), for: UIControl.Event.touchUpInside)
        shutter_button.addTarget(self, action: #selector(cameraAction(_:)), for: UIControl.Event.touchUpInside)
        // ラベルを設定する
        button1.setTitle("確認", for: UIControl.State.normal)
      
        // サイズ
        button1.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        shutter_button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        // 位置
        button1.layer.position = CGPoint(x: 45, y:self.view.frame.height - 45)
        shutter_button.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height - 45)
        // 背景色
        button1.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.6, alpha: 1)
      
        // 枠の太さ
        button1.layer.borderWidth = 0.5
      
        // 枠の色
        button1.layer.borderColor = UIColor(red: 0.3, green: 0.6, blue: 0.5, alpha: 1).cgColor
      
        // 枠に丸み
        button1.layer.cornerRadius = 25
      
        // viewに追加する
        self.view.addSubview(button1)
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
        }
        catch {
            print(error)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
       
    @objc func cameraAction(_ sender: AnyObject) {
        // カメラの設定
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
            
            // アルバムに追加.
            
            //UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
            
            // フォトライブラリに保存
    }
    @objc func saveImage(_ sender: AnyObject ) {
        goToNextPage()
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
    
}

