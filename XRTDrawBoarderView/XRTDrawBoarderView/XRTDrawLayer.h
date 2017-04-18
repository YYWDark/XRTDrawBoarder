//
//  XRTDrawLayer.h
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface XRTDrawLayer : CAShapeLayer
+ (instancetype)drawlayerWithLineWidth:(CGFloat)lineWidth
                            bezierPath:(CGPathRef)path
                    lineStrokeColorHex:(NSString *)strokeColorHex
                      lineFillColorHex:(NSString *)fillColorHex;
@end
