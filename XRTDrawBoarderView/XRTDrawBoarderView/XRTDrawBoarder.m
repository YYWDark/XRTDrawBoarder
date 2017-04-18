//
//  XRTDrawBoarder.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "XRTDrawBoarder.h"
#import "XRTDrawLayer.h"
#import "XRTDrawView.h"
#import "XRTDrawBezierPath.h"
#import "XRTDrawToolView.h"
#import "UIView+DrawScreenShot.h"

@interface XRTDrawBoarder () <XRTDrawToolViewDelegate>
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) XRTDrawToolView *toolView;
@property (nonatomic, strong) XRTDrawView *drawView;
@end

@implementation XRTDrawBoarder
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _configuration = [XRTDrawerConfiguration new];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                configuration:(XRTDrawerConfiguration *)configuration {
   self = [self initWithFrame:frame];
    if (self) {
        _configuration = configuration;
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
   [super layoutSubviews];
    if (self.configuration.isShowingToolview) {
        _toolView.frame = CGRectMake(0, 0, self.frame.size.width, self.configuration.toolViewHeight);
        _bgImageView.frame = CGRectMake(0,self.configuration.toolViewHeight, self.frame.size.width, self.frame.size.height - self.configuration.toolViewHeight);
        _drawView.frame = _bgImageView.bounds;

    }else {
     _bgImageView.frame = self.bounds;
        _drawView.frame = self.bounds;
    }

}

#pragma mark - private method
- (void)initUI {
    [self addSubview:self.bgImageView];
    [self addSubview:self.drawView];
    if (self.configuration.isShowingToolview) {
        [self addSubview:self.toolView];
    }
   
}

- (void)_lastStep {
    [self.drawView lastStep];
}

- (void)_nextStep {
    [self.drawView nextStep];
}

- (void)_save {
    UIImage *screenShotImage = [self.drawView screenShotFromSourceView];
    UIImageWriteToSavedPhotosAlbum(screenShotImage, nil, nil, nil);
    if ([self.delegate respondsToSelector:@selector(drawBoarder:saveImage:)]) {
        [self.delegate drawBoarder:self saveImage:screenShotImage];
    }
}

- (void)_delete {
    [self.drawView deleteAllLines];
}

#pragma mark - public method
- (void)show {
    
}

- (void)dismiss {
    
}

#pragma mark - XRTDrawToolViewDelegate
- (void)drawToolView:(XRTDrawToolView *)drawToolView event:(XRTDrawButtonEvent)event {
    NSLog(@"event == %ld",event);
    switch (event) {
        case XRTDrawButtonEventLastStep:
            [self _lastStep];
            break;
        case XRTDrawButtonEventNextStep:
            [self _nextStep];
            break;
        case XRTDrawButtonEventSave:
            [self _save];
            break;
        case XRTDrawButtonEventDelete:
            [self _delete];
            break;
        default:
            break;
    }
}

#pragma mark - set
- (void)setBgImageName:(NSString *)bgImageName {
    if (_bgImageName != bgImageName) {
        _bgImageName = bgImageName;
        self.bgImageView.image = [UIImage imageNamed:_bgImageName];
    }
}

//- (void)setConfiguration:(XRTDrawerConfiguration *)configuration {
//    if (_configuration != configuration) {
//        _configuration = configuration;
//    }
//}
#pragma mark - get
- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (XRTDrawToolView *)toolView {
    if (_toolView == nil) {
        _toolView = [[XRTDrawToolView alloc] initWithFrame:CGRectZero];
        _toolView.delegate = self;
    }
    return _toolView;
}

- (XRTDrawView *)drawView {
    if (_drawView == nil) {
        _drawView = [[XRTDrawView alloc] initWithFrame:CGRectZero configuration:self.configuration];
    }
    return _drawView;
}


@end
