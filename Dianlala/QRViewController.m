//
//  QRViewController.m
//  Dianlala
//
//  Created by MexiQQ on 14/11/26.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "QRViewController.h"

@interface QRViewController ()
@end

@implementation QRViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [self.navigationController.navigationBar setHidden:YES];
  [_resetButton defaultStyle];
  [_QRView setBackgroundColor:[UIColor colorWithRed:33.0 / 255.0f
                                              green:166.0 / 255.0f
                                               blue:96.0 / 255.0f
                                              alpha:1]];

  // 给 label 增加点击事件
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(startScaning:)];
  _imageButton.userInteractionEnabled = YES;
  [_imageButton addGestureRecognizer:tap];
}

#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

- (IBAction)startScaning:(id)sender {
  if (IOS7) {
    UIStoryboard *mainStoryboard =
        [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id viewController =
        [mainStoryboard instantiateViewControllerWithIdentifier:@"erweimaPage"];
    [self.navigationController pushViewController:viewController animated:YES];
  }
}
- (IBAction)resetAction:(id)sender {
  UIStoryboard *mainStoryboard =
      [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  id viewController =
      [mainStoryboard instantiateViewControllerWithIdentifier:@"resetPage"];
  [self.navigationController pushViewController:viewController animated:YES];
}

@end
