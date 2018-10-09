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
    @IBOutlet weak var image1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image1.image = img7
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Saveimg(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(img7, self, nil, nil)
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
