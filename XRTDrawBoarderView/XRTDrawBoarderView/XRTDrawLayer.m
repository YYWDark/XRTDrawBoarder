//
//  XRTDrawLayer.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "XRTDrawLayer.h"
#import <UIKit/UIKit.h>
#import "UIColor+DrawExtension.h"
@implementation XRTDrawLayer
+ (instancetype)drawlayerWithLineWidth:(CGFloat)lineWidth
                            bezierPath:(CGPathRef)path
                    lineStrokeColorHex:(NSString *)strokeColorHex
                      lineFillColorHex:(NSString *)fillColorHex {
    XRTDrawLayer *drawLayer = [XRTDrawLayer layer];
    drawLayer.path = path;
    drawLayer.fillColor = [UIColor clearColor].CGColor;
    drawLayer.lineCap = kCALineCapRound;
    drawLayer.lineJoin = kCALineJoinRound;
    drawLayer.strokeColor = [UIColor draw_colorWithHexString:strokeColorHex].CGColor;
    drawLayer.lineWidth = lineWidth;
    return drawLayer;
}

@end
