//
//  XRTDrawBoarder.h
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRTDrawerConfiguration.h"

@protocol XRTDrawBoarderDelegate;
@interface XRTDrawBoarder : UIView
@property (nonatomic, copy) NSString *bgImageName;
@property (nonatomic, weak) id <XRTDrawBoarderDelegate> delegate;
@property (nonatomic, strong, readonly) XRTDrawerConfiguration *configuration;

- (instancetype)initWithFrame:(CGRect)frame
                configuration:(XRTDrawerConfiguration *)configuration;
- (void)show;
- (void)dismiss;

@end


@protocol XRTDrawBoarderDelegate <NSObject>
@optional
- (void)drawBoarder:(XRTDrawBoarder *)drawBoarder saveImage:(UIImage *)image;
@end
