//
//  XRTToolView.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/18.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "XRTDrawToolView.h"
#import "XRTDrawButton.h"
#import "UIColor+DrawExtension.h"
@interface XRTDrawToolView ()
@property (nonatomic, strong) NSArray *eventArray;
@end

@implementation XRTDrawToolView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self _initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnWidth  = self.frame.size.width/self.eventArray.count;
    CGFloat btnHeight = self.frame.size.height;
    
    for (int index = 0; index < self.subviews.count; index ++) {
        XRTDrawButton *btn = self.subviews[index];
        btn.frame = CGRectMake(btnWidth*index, 0, btnWidth, btnHeight);
    }
}

- (void)respondsToTapAction:(XRTDrawButton *)sender {
    if ([self.delegate respondsToSelector:@selector(drawToolView:event:)]) {
        [self.delegate drawToolView:self event:sender.event];
    }
}

- (void)_initUI {
    if (self.eventArray.count == 0) return;
    for (int index = 0; index < self.eventArray.count; index ++) {
        XRTDrawButton *btn = [XRTDrawButton buttonWithType:UIButtonTypeSystem];
        btn.event = [self.eventArray[index] integerValue];
        [btn setTitle:[self findStringByEvent:btn.event] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(respondsToTapAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:btn];
    }
    
}

- (NSArray *)eventArray {
    if (_eventArray == nil) {
        _eventArray = @[@(XRTToolViewEventLastStep),@(XRTToolViewEventNextStep),@(XRTToolViewEventSave),@(XRTToolViewEventDelete)];
    }
    return _eventArray;
}


- (NSString *)findStringByEvent:(XRTDrawButtonEvent)event {
    
    switch (event) {
        case XRTDrawButtonEventLastStep:
            return @"上一步";
            break;
            
        case XRTDrawButtonEventNextStep:
            return @"下一步";
            break;
            
        case XRTDrawButtonEventSave:
            return @"保存";
            break;
            
        case XRTToolViewEventDelete:
            return @"删除";
            break;
    }
    return nil;
}
@end
