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
typedef NS_ENUM(NSUInteger, XRTDrawBoarderActionType) {
    XRTDrawBoarderActionTypeNone = 0,
    XRTDrawBoarderActionTypeClear = 1,
    XRTDrawBoarderActionTypeSave = 2,
};


 
@interface XRTDrawBoarder () <XRTDrawToolViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) XRTDrawToolView *toolView;
@property (nonatomic, strong) XRTDrawView *drawView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL isDrawing;
@property (nonatomic, assign) XRTDrawBoarderActionType actionType;
@end

@implementation XRTDrawBoarder
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _configuration = [XRTDrawerConfiguration new];
        _actionType = XRTDrawBoarderActionTypeNone;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                configuration:(XRTDrawerConfiguration *)configuration {
   self = [self initWithFrame:frame];
    if (self) {
        _configuration = configuration;
        if (_configuration.souceImage == nil)
            self.isDrawing = NO;
        
        [self initUI];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//                configuration:(XRTDrawerConfiguration *)configuration
//                  sourceImage:(UIImage *)image {
//    self = [self initWithFrame:frame];
//    if (self) {
//        _image = image;
//        _configuration = configuration;
//        
//        [self initUI];
//    }
//    return self;
//}

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"不能进行签名编辑，只有清空后才能继续编辑");
    return;
}

#pragma mark - private method
- (void)initUI {
    [self addSubview:self.bgImageView];
    [self addSubview:self.drawView];
    if (self.configuration.isShowingToolview) {
        [self addSubview:self.toolView];
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, window.frame.size.height, window.frame.size.width);
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
            if (self.isDrawing == NO) {
                NSLog(@"签名没有改变，不需要重复保存");
                return;
            }else {
              _actionType = XRTDrawBoarderActionTypeSave;
            [self showAlertTitle:@"提示" message:@"是否保存签名?" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            }
            
            break;
        case XRTDrawButtonEventDelete:
                _actionType = XRTDrawBoarderActionTypeClear;
                [self showAlertTitle:@"提示" message:@"是否清楚当前的画布？" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];

                return;
            
            break;
        default:
            break;
    }
}

- (void)hiddenThebgImageView {
    if (self.isDrawing == NO) {
        self.isDrawing = YES;
        self.drawView.hidden = NO;
        self.bgImageView.hidden = YES;
    } else {
        [self _delete];
    }
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
       leftButtonTitle:(NSString *)leftTitle
      rightButtonTitle:(NSString *)righTtitle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:righTtitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确认");
        switch (_actionType) {
            case XRTDrawBoarderActionTypeSave:
                [self _save];
                break;
            case XRTDrawBoarderActionTypeClear:
                [self hiddenThebgImageView];
                break;
            default:
                break;
        }
    }];
    
 
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    
    
}
#pragma mark - set

#pragma mark - get
- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = _configuration.souceImage;
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
        _drawView.hidden = !self.isDrawing;
    }
    return _drawView;
}


@end
