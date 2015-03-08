//
//  ConfirmViewController.m
//  Dianlala
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "ConfirmViewController.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _nameLabel.text =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];

  _studentNumberLable.text =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

- (void)viewWillAppear:(BOOL)animated {
  [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (IBAction)confirmSuccess:(id)sender {
  UIStoryboard *mainStoryboard =
      [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  id viewController =
      [mainStoryboard instantiateViewControllerWithIdentifier:@"rootPage"];
  [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)cancelAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
