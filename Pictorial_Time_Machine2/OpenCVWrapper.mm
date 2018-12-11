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
#include <vector>
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

//領域分割
+(UIImage * )filter :(UIImage *)imagef nightImage2:(UIImage * )nightImage2
{
    cv::Mat src_img;
    cv::Mat getimage;
    cv::Mat img_copy = getimage.clone();
    
    UIImageToMat(imagef, getimage);
    UIImageToMat(nightImage2, src_img);
    
    //if(getimage.channels() == 1)return imagef;
    
    
    
    
    
    // transform the cv::Mat color image to gray
    cv::Mat grayMat;
    
    cv::cvtColor (getimage, grayMat, CV_BGR2GRAY);
    

    
    //グレースケール化完了
    
    cv::Mat mask;
    cv::Mat im_mask;
    //ここから２ち値化
    //cv::threshold(grayMat,mask,200,255,cv::THRESH_BINARY);
    cv::threshold(grayMat, im_mask, 0, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);
    
    
    
    
    //cv::cvtColor (getmask, finish_image, CV_GRAY2BGR );

    //ノイズ除去
    
    cv::Mat opening;
    cv::Mat kernel(3, 3, CV_8U, cv::Scalar(1));
    cv::morphologyEx(im_mask, opening, cv::MORPH_OPEN, kernel, cv::Point(-1,-1), 2);
    
    // 背景領域抽出
    cv::Mat sure_bg;
    cv::dilate(opening, sure_bg, kernel, cv::Point(-1,-1), 3);
    
    
    //前景領域抽出

    cv::Mat dist_transform;
    cv::distanceTransform(opening, dist_transform, CV_DIST_L2, 5);
    
    cv::Mat sure_fg;
    //double maxVal ;
    //cv::threshold(dist_transform, sure_fg, 0.5*maxVal, 255, CV_THRESH_BINARY);
    
    double mindist, maxdist;
    cv::Point minLocon, maxLocon;
    cv::minMaxLoc(dist_transform, &mindist, &maxdist, &minLocon, &maxLocon);
    dist_transform = dist_transform/maxdist;

    cv::threshold(dist_transform, sure_fg, 0.2*maxdist, 255, CV_THRESH_BINARY);
    
   
    
    
    
    //不透明領域つ抽出
    cv::Mat unknown, sure_fg_uc1;
    sure_fg.convertTo(sure_fg_uc1, CV_8UC1);
    cv::subtract(sure_bg, sure_fg_uc1, unknown);
    
    cv::Mat markers;
    //int cv::connectedComponents(sure_fg, markers, <#int connectivity#>, <#int ltype#>, <#int ccltype#>);
    
    
    
  
    /*
    
     
    // 前景ラベリング
    int compCount = 0;
    std::vector<std::vector<cv::Point> > contours;
    std::vector<cv::Vec4i> hierarchy;
    sure_fg.convertTo(sure_fg, CV_32SC1, 1.0);
    cv::findContours(sure_fg, contours, hierarchy, cv::RETR_CCOMP, cv::CHAIN_APPROX_SIMPLE);
    //if( contours.empty() ) return;
    cv::Mat markers = cv::Mat::zeros(sure_fg.rows, sure_fg.cols, CV_32SC1);
    int idx = 0;
    for( ; idx >= 0; idx = hierarchy[idx][0], compCount++ )
        cv::drawContours(markers, contours, idx, cv::Scalar::all(compCount+1), -1, 8, hierarchy, INT_MAX);
    markers = markers+1;
    
    // 不明領域は今のところゼロ
    for(int i=0; i<markers.rows; i++){
        for(int j=0; j<markers.cols; j++){
            unsigned char &v = unknown.at<unsigned char>(i, j);
            if(v==255){
                markers.at<int>(i, j) = 0;
            }
        }
    }
    
    cv::Mat wshed(markers.size(), CV_8UC3);
    std::vector<cv::Vec3b> colorTab;
    for(int i = 0; i < compCount; i++ )
    {
        int b = cv::theRNG().uniform(0, 255);
        int g = cv::theRNG().uniform(0, 255);
        int r = cv::theRNG().uniform(0, 255);
        
        colorTab.push_back(cv::Vec3b((uchar)b, (uchar)g, (uchar)r));
    }
    
    // paint the watershed image
    for(int i = 0; i < markers.rows; i++ ){
        for(int j = 0; j < markers.cols; j++ )
        {
            int index = markers.at<int>(i,j);
            if( index == -1 )
                wshed.at<cv::Vec3b>(i,j) = cv::Vec3b(255,255,255);
            else if( index <= 0 || index > compCount )
                wshed.at<cv::Vec3b>(i,j) = cv::Vec3b(0,0,0);
            else
                wshed.at<cv::Vec3b>(i,j) = colorTab[index - 1];
        }
    }
    
    cv::Mat imgG;
    cvtColor(grayMat, imgG, cv::COLOR_GRAY2BGR);
    wshed = wshed*0.5 + imgG*0.5;
    
    
    */
    
    return MatToUIImage(sure_fg);
    
    
    
}




//星空出すやつ
+(UIImage * ) inthedarkFromImage:(UIImage *)imageb nightImage:(UIImage * )nightImage
{
    // transform UIImagge to cv::Mat
    cv::Mat getMat;
    cv::Mat getnightImage;
    //getMatをコピー
    cv::Mat img_copy = getMat.clone();
    UIImageToMat(imageb, getMat);
    UIImageToMat(nightImage, getnightImage);
    // if the image already grayscale, return it
    //if(getMat.channels() == 1)return imageb;
    
    // transform the cv::Mat color image to gray
    cv::Mat grayMat;
    cv::cvtColor (getMat, grayMat, CV_BGR2GRAY);
    
    
    
    //ガンマ補正で暗くする
    float gamma ;
    
    gamma = 0.4;
    
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
    
    
    cv::Mat destination;
    cv::Mat destination2;
    addWeighted(getMat, 0.5, result, 0.5, 0.0, destination);
    addWeighted(result, 0.5, destination, 0.5, 0.0, destination2);

    
    
    
    
    
    //2値化(マスク画像１)
    cv::threshold(grayMat, grayMat, 0, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);
    
    
    
    //ノイズ除去
    
    cv::Mat opening;
    cv::Mat kernel(3, 3, CV_8U, cv::Scalar(1));
    cv::morphologyEx(grayMat, opening, cv::MORPH_OPEN, kernel, cv::Point(-1,-1), 2);

    
    // 背景領域抽出
    cv::Mat sure_bg;
    cv::dilate(opening, sure_bg, kernel, cv::Point(-1,-1), 3);
    
    
    //星空の画像をマスク処理
    cv::Mat getmask_star;
    cv::Mat gray_night;
    cv::Mat color_mask_star;
    cv::Mat resize_star;
    
    cv::cvtColor(sure_bg, color_mask_star, CV_GRAY2RGBA);
    cv::resize(getnightImage, resize_star, color_mask_star.size(), 0, 0, cv::INTER_LINEAR);
    //ビットアンドによるマスク処理
    cv::bitwise_and(resize_star, color_mask_star, getmask_star);
    //星空のマスク画像完成
    
    
    
    
    
    //ここから暗くした町の画像をマスク処理
    //マスク画像2作成
    cv::Mat rivers_mask;
    cv::bitwise_not(grayMat, rivers_mask);
    
    //町マスク処理
    cv::Mat getmask_house;
    cv::Mat gray_night_house;
    cv::Mat color_mask_house;
    cv::Mat resize_night_house;
    
    
    cv::cvtColor(rivers_mask, color_mask_house, CV_GRAY2RGBA);
    cv::resize(destination2, resize_night_house, color_mask_house.size(), 0, 0, cv::INTER_LINEAR);
    
    cv::bitwise_and(resize_night_house, color_mask_house, getmask_house);
    
    
    
    //マスク画像1,2を合体
    cv::Mat perfect_get;
    cv::Mat resize_gethouse;
    cv::resize(getmask_house, resize_gethouse, getmask_star.size(), 0, 0, cv::INTER_LINEAR);
    //addWeighted(resize_gethouse, 0.5, getmask_star, 0.5, 0.0, perfect_get);
    cv::add(resize_gethouse, getmask_star, perfect_get);
    
    return MatToUIImage(perfect_get);
}

//夕方風？
+(UIImage * ) intheEveningFromImage:(UIImage *)imageb nightImage:(UIImage * )nightImage
{
    // transform UIImagge to cv::Mat
    cv::Mat getMat;
    cv::Mat getnightImage;
    //getMatをコピー
    cv::Mat img_copy = getMat.clone();
    UIImageToMat(imageb, getMat);
    UIImageToMat(nightImage, getnightImage);
    // if the image already grayscale, return it
    //if(getMat.channels() == 1)return imageb;
    
    // transform the cv::Mat color image to gray
    cv::Mat grayMat;
    cv::cvtColor (getMat, grayMat, CV_BGR2GRAY);
    
    
    
    //ガンマ補正で暗くする
    float gamma = 0.08;
    
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
    
    
    cv::Mat destination;
    cv::Mat destination2;
    addWeighted(getMat, 0.5, result, 0.5, 0.0, destination);
    addWeighted(result, 0.5, destination, 0.5, 0.0, destination2);
    
    return MatToUIImage(destination2);
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
