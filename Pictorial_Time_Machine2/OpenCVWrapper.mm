//
//  OpenCVWrapper.m
//  Pictorial_Time_Machine2
//
//  Created by 稲村　和佳 on 2018/10/14.
//  Copyright © 2018年 稲村　和佳. All rights reserved.
//

#import "opencv2/opencv.hpp"
#import "opencv2/imgcodecs/ios.h"
#import "opencv2/imgproc/imgproc.hpp"
#import "OpenCVWrapper.h"

//BGRで
#define B_MAX 250
#define B_MIN 200
#define G_MAX 250
#define G_MIN 200
#define R_MAX 250
#define R_MIN 200


//HSVで
#define H_MAX 180
#define H_MIN 160
#define S_MAX 255
#define S_MIN 50
#define V_MAX 255
#define V_MIN 50

@interface OpenCVWrapper ()

@end

@implementation OpenCVWrapper

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(NSString *) openCVVersionString
{
    return [NSString stringWithFormat: @"openCV Version %s", CV_VERSION];
}


+(UIImage * ) makeGrayFromImage:(UIImage *)image
{
    // transform UIImagge to cv::Mat
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    // if the image already grayscale, return it
    if(imageMat.channels() == 1)return image;
    
    // transform the cv::Mat color image to gray
    cv::Mat grayMat;
    cv::cvtColor (imageMat, grayMat, CV_BGR2GRAY);
    
    
    //１次微分画像？
    cv::Mat tmp_img;
    cv::Mat sobel_img;
    Sobel(grayMat, tmp_img,CV_32F ,1, 1);
    convertScaleAbs(tmp_img, sobel_img, 1, 0);
    
    //2次微分？
    cv::Mat laplacian_img;
    Laplacian(grayMat, tmp_img, CV_32F, 3);
    convertScaleAbs(tmp_img, laplacian_img, 1, 0);
    
    
    //エッジ検出？
    cv::Mat canny_img;
    Canny(grayMat, canny_img, 50, 200);
    
    return MatToUIImage(canny_img);
    
    
   
}

//色検出
+(UIImage * ) whiteGetFromImage:(UIImage *)imagew
{
    
    
    cv::Mat getimageMat;
    
    
    UIImageToMat(imagew, getimageMat);
    if(getimageMat.channels() == 1)return imagew;
    //色
    cv::Mat mask_image, output_image_rgb, hsv_image,colorimage;
   
    // BGRからHSVへ変換
    cv::cvtColor(getimageMat, hsv_image, CV_BGR2HSV, 3);
    cv::cvtColor(getimageMat, colorimage, CV_LOAD_IMAGE_COLOR);
    
    //HSV検出
    /*
    cv::Scalar s_min = cvScalar(H_MIN, S_MIN, V_MIN);
    cv::Scalar s_max = cvScalar(H_MAX, S_MAX, V_MAX);
    inRange(hsv_image, s_min, s_max, mask_image);
    */
    
    //色で検出
    cv::Scalar s_min = cvScalar(R_MIN, G_MIN, B_MIN);
    cv::Scalar s_max = cvScalar(R_MAX, G_MAX, B_MAX);
    inRange(colorimage, s_min, s_max, mask_image);
    
    return MatToUIImage(mask_image);
}


//ガンマ補正
+(UIImage * ) inthedarkFromImage:(UIImage *)imageb
{
    // transform UIImagge to cv::Mat
    cv::Mat getMat;
    UIImageToMat(imageb, getMat);
    
    // if the image already grayscale, return it
    if(getMat.channels() == 1)return imageb;
    
    // transform the cv::Mat color image to gray
    cv::Mat grayMat;
    cv::cvtColor (getMat, grayMat, CV_BGR2GRAY);
    
    
    float gamma = 0.3;
    
    uchar lut[256];
    double gm = 1.0 / gamma;
    for (int i = 0; i < 256; i++)
        lut[i] = pow(1.0*i/255, gm) * 255;
    
    // 輝度値の置き換え処理
    // Matを1行として扱う（高速化のため）
    cv::Mat p = getMat.reshape(0, 1).clone();
    for (int i = 0; i < p.cols; i++) {
       p.at<uchar>(0, i) = lut[p.at<uchar>(0, i)];
    }
    // 元の形にもどす
    cv::Mat result = p.reshape(0, getMat.rows);

    LUT(getMat, cv::Mat(cv::Size(256, 1), CV_8U, lut), result);
    
    return MatToUIImage(result);
}



+(NSString *) openCVGasoString:image
{
    cv::Mat testImage;
    UIImageToMat(image, testImage);
    
    cv::Vec3b bgr = testImage.at<cv::Vec3b>(100, 100);
    
    //px = image[static_cast<void>(100),100];
    return [NSString stringWithFormat: @"%d,%d,%d\n",bgr[0],bgr[1],bgr[2]];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
