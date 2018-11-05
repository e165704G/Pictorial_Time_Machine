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
        
        image1.image = image3
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func Saveimg(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image3, self, nil, nil)
        //gaso.text = OpenCVWrapper.openCVGasoString(image3)
    }
    
    @IBAction func toGrayScaleButtonTouched(_ sender: Any) {
        
        
        UIGraphicsBeginImageContextWithOptions(image1.image!.size, false, 0.0)
        image1.image!.draw(in:(CGRect(x:0,y:0,width:image1.image!.size.width,height:image1.image!.size.height)))
        image1.image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        image1.image = OpenCVWrapper.makeGray(from: image1.image!)
        image3 = OpenCVWrapper.makeGray(from: image1.image!)
        
    }
    
    
    @IBAction func getColor(_ sender: Any) {
        //画像の向き固定
        UIGraphicsBeginImageContextWithOptions(image1.image!.size, false, 0.0)
        image1.image!.draw(in:(CGRect(x:0,y:0,width:image1.image!.size.width,height:image1.image!.size.height)))
        image1.image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        image1.image = OpenCVWrapper.whiteGet(from: image1.image!)
        image3 = OpenCVWrapper.whiteGet(from: image1.image!)
    }
    
    
    
    @IBAction func pulusDark(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(image1.image!.size, false, 0.0)
        image1.image!.draw(in:(CGRect(x:0,y:0,width:image1.image!.size.width,height:image1.image!.size.height)))
        image1.image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        image1.image = OpenCVWrapper.inthedark(from: image1.image!)
        image3 = OpenCVWrapper.inthedark(from: image1.image!)
        
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
