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
   
    @IBOutlet weak var image1: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.cyan
        
        image1.image = image3
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func Saveimg(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image3, self, nil, nil)
    }
    
    @IBAction func toGrayScaleButtonTouched(_ sender: Any) {
        let TestView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: 400, height: 550))
        let bgColor = UIColor .black
        TestView.backgroundColor = bgColor
        TestView.alpha = 0.7
        self.view.addSubview(TestView)
        
        
        
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
