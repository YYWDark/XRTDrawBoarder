//
//  XRTDrawView.h
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRTDrawerConfiguration.h"

@interface XRTDrawView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                configuration:(XRTDrawerConfiguration *)configuration;

- (void)lastStep;
- (void)nextStep;
- (void)save;
- (void)deleteAllLines;
@end
