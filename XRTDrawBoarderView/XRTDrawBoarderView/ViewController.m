//
//  ViewController.m
//  XRTDrawBoarderView
//
//  Created by wyy on 2017/4/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "XRTDrawViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image = [UIImage imageNamed:@"icon_add.png"];
    [self.view addSubview:self.imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//    
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//    [self presentViewController:alertController animated:YES completion:nil];
    
    
    XRTDrawViewController *viewController = [XRTDrawViewController new];
    viewController.sourceimage = self.image;
    __weak ViewController *weakSelf = self;
    viewController.imageBlock = ^(UIImage *drawImage){
        self.image = drawImage;
        weakSelf.imageView.image = self.image;
    };
    
    [self presentViewController:viewController animated:YES completion:nil];
}


- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _imageView.frame = CGRectMake(0, 0, 100, 100);
        _imageView.image = self.image;
        _imageView.center = self.view.center;
        _imageView.layer.borderWidth = 1.0f;
        _imageView.layer.borderColor = [UIColor blackColor].CGColor
        ;
    }
    return _imageView;
}
@end
