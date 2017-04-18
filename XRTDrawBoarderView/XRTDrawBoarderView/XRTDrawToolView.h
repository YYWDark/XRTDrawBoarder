//
//  XRTToolView.h
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/18.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRTDrawButton.h"
typedef NS_ENUM(NSUInteger, XRTDrawToolViewEvent) {
    XRTToolViewEventLastStep,
    XRTToolViewEventNextStep,
    XRTToolViewEventSave,
    XRTToolViewEventDelete,
};

@protocol XRTDrawToolViewDelegate;
@interface XRTDrawToolView : UIView
@property (nonatomic, weak) id <XRTDrawToolViewDelegate> delegate;
@end

@protocol XRTDrawToolViewDelegate <NSObject>
@optional
- (void)drawToolView:(XRTDrawToolView *)drawToolView event:(XRTDrawButtonEvent)event;
@end
