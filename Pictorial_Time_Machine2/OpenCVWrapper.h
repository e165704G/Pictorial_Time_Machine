//
//  OpenCVWrapper.h
//  Pictorial_Time_Machine2
//
//  Created by 稲村　和佳 on 2018/10/14.
//  Copyright © 2018年 稲村　和佳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : UIViewController

+(NSString * ) openCVVersionString;

// function to convert image to grayscale
+(UIImage * ) makeGrayFromImage:(UIImage * ) image;

//画素値習得
+(NSString *) openCVGasoString:image;


//色検出
+(UIImage * ) whiteGetFromImage:(UIImage * ) imagew;

//ガンマ補正
+(UIImage * ) inthedarkFromImage:(UIImage *)imageb;


//watershed？
+(UIImage * ) filterFromImage:(UIImage *)imagef;


@end

NS_ASSUME_NONNULL_END
