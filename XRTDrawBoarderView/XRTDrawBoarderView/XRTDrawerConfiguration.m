//
//  XRTDrawerConfiguration.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "XRTDrawerConfiguration.h"

@implementation XRTDrawerConfiguration
- (instancetype)init {
    self = [super init];
    if (self) {
        self.lineWidth = 2.0f;
        self.isShowingToolview = YES;
        self.toolViewHeight = 30.0f;
        self.strokeColorHex = @"000000";
    }
    return self;
}
@end
