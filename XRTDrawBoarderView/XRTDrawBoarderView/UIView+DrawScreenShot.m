//
//  UIView+DrawScreenShot.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/18.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "UIView+DrawScreenShot.h"

@implementation UIView (DrawScreenShot)
- (UIImage *)screenShotFromSourceView {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return getImage;
}
@end
