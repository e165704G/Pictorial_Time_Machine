//
//  OpenCVWrapper.m
//  Pictorial_Time_Machine2
//
//  Created by 稲村　和佳 on 2018/10/14.
//  Copyright © 2018年 稲村　和佳. All rights reserved.
//
#import "opencv2/opencv.hpp"
#import "opencv2/imgcodecs/ios.h"
#import "OpenCVWrapper.h"


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
    
    return MatToUIImage(grayMat);
    
    
   
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
