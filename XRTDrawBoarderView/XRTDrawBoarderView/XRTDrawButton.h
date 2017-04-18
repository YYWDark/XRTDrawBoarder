//
//  XRTDrawButton.h
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/18.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, XRTDrawButtonEvent) {
    XRTDrawButtonEventLastStep,
    XRTDrawButtonEventNextStep,
    XRTDrawButtonEventSave,
    XRTDrawButtonEventDelete,
};

@interface XRTDrawButton : UIButton
@property (nonatomic, assign) XRTDrawButtonEvent event;
@end
