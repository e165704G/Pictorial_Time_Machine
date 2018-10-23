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
    
    @IBOutlet weak var openCVversionLabel: UILabel!
    

    @IBOutlet weak var cameraView: UIView!
    
    
    var captureSesssion: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.cyan
        
        //opencvの基礎　バージョンを表示
        openCVversionLabel.text = OpenCVWrapper.openCVVersionString()
        
        
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
       
    @IBAction func cameraAction(_ sender: AnyObject) {
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
    @IBAction func saveImage(_ sender: AnyObject ) {
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

