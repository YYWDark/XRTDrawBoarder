//
//  XRTDrawBezierPath.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "XRTDrawBezierPath.h"

@implementation XRTDrawBezierPath
+ (instancetype)drawBezerPathWithLineWidth:(CGFloat)lineWidth
                                startPoint:(CGPoint)point {
    XRTDrawBezierPath * path = [[self alloc] init];
    path.lineWidth = lineWidth;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path moveToPoint:point];
    return path;
}
@end
