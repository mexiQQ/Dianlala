//
//  ValidSuccessViewController.m
//  Dianlala
//
//  Created by MexiQQ on 14/12/4.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "ValidSuccessViewController.h"

@interface ValidSuccessViewController ()

@end

@implementation ValidSuccessViewController
@synthesize Info = _Info;
- (void)viewDidLoad {
  [super viewDidLoad];
  _Infolabel.text = _Info;
  // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
  [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
