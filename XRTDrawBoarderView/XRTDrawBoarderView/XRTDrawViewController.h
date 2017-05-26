//
//  XRTDrawViewController.h
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/18.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageBlock)(UIImage *drawImage);
@interface XRTDrawViewController : UIViewController
@property (nonatomic, copy) ImageBlock imageBlock;
@property (nonatomic, strong) UIImage *sourceimage;
@end
