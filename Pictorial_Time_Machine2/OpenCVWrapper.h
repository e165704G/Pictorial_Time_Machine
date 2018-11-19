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


//画素値習得
+(NSString *) openCVGasoString:image;



//ガンマ補正
+(UIImage * ) inthedarkFromImage:(UIImage *)imageb nightImage:(UIImage * )nightImage;


//watershed？
+(UIImage * ) filter :(UIImage *)imagef nightImage2:(UIImage * )nightImage2;


@end

NS_ASSUME_NONNULL_END
