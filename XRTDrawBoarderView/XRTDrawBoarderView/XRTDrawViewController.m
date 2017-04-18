//
//  XRTDrawViewController.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/18.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "XRTDrawViewController.h"
#import "XRTDrawBoarder.h"
@interface XRTDrawViewController () <XRTDrawBoarderDelegate>
@property (nonatomic, strong) XRTDrawBoarder *boarder;
@end

@implementation XRTDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.boarder];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (XRTDrawBoarder *)boarder {
    if(_boarder == nil) {
        XRTDrawerConfiguration *configuration = [[XRTDrawerConfiguration alloc] init];
        _boarder = [[XRTDrawBoarder alloc] initWithFrame:self.view.bounds configuration:configuration];
        _boarder.delegate = self;
    }
    return _boarder;
}

- (void)drawBoarder:(XRTDrawBoarder *)drawBoarder saveImage:(UIImage *)image {
    
    if (self.imageBlock) {
        self.imageBlock(image);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
