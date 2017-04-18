//
//  UIColor+DrawExtension.h
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/18.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DrawExtension)
+ (UIColor *)draw_colorWithHexString:(NSString *)hexString;
+ (UIColor *)draw_randomColor;
@end
