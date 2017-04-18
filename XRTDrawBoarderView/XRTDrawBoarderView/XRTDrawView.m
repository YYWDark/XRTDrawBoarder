//
//  XRTDrawView.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "XRTDrawView.h"
#import "XRTDrawLayer.h"
#import "XRTDrawBezierPath.h"

@interface XRTDrawView ()
@property (nonatomic, strong) NSMutableArray *drawLines;          /* 用户绘制的线**/
@property (nonatomic, strong) NSMutableArray *canceLines;
@property (nonatomic, strong) XRTDrawLayer *drwaLayer;
@property (nonatomic, strong) XRTDrawBezierPath *currentPath;
@property (nonatomic, strong) XRTDrawerConfiguration *configuration;
@end

@implementation XRTDrawView
- (instancetype)initWithFrame:(CGRect)frame
                configuration:(XRTDrawerConfiguration *)configuration {
    self = [super initWithFrame:frame];
    if (self) {
        self.configuration = configuration;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:self];
    NSLog(@"%@",NSStringFromCGPoint(startPoint));
    
    _currentPath = [XRTDrawBezierPath drawBezerPathWithLineWidth:self.configuration.lineWidth startPoint:startPoint];
    
    _drwaLayer = [XRTDrawLayer drawlayerWithLineWidth:self.configuration.lineWidth bezierPath:_currentPath.CGPath lineStrokeColorHex:self.configuration.strokeColorHex lineFillColorHex:self.configuration.strokeColorHex];
    
    [self.layer addSublayer:_drwaLayer];
    
    
    //移除
    [self.canceLines removeAllObjects];
    [self.drawLines addObject:_drwaLayer];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    [_currentPath addLineToPoint:movePoint];
    _drwaLayer.path = _currentPath.CGPath;
}

- (void)lastStep {
    if (_drawLines.count == 0) return;
    [self.canceLines addObject:self.drawLines.lastObject];
    [self.drawLines.lastObject removeFromSuperlayer];
    [self.drawLines removeLastObject];
}

- (void)nextStep {
    if (_canceLines.count == 0) return;
    [self.drawLines addObject:self.canceLines.lastObject];
    [self.canceLines removeLastObject];
    [self.layer addSublayer:self.drawLines.lastObject];
}

- (void)save {
    
}

- (void)deleteAllLines {
    if (_drawLines.count == 0) return;
    [_drawLines makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_drawLines removeAllObjects];
    [_canceLines removeAllObjects];
}

- (NSMutableArray *)drawLines {
    if (_drawLines == nil) {
        _drawLines = [NSMutableArray array];
    }
    return _drawLines;
}

- (NSMutableArray *)canceLines {
    if (_canceLines == nil) {
        _canceLines = [NSMutableArray array];
    }
    return _canceLines;
}
@end
