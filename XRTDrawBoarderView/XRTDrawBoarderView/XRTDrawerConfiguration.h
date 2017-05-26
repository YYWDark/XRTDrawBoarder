//
//  XRTDrawerConfiguration.h
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XRTDrawerConfiguration : NSObject
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat toolViewHeight;
@property (nonatomic, assign) BOOL isShowingToolview;
@property (nonatomic, strong) UIImage *souceImage;
@property (nonatomic, copy) NSString *strokeColorHex;
@end
