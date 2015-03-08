//
//  ResetBindViewController.m
//  Dianlala
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "ResetBindViewController.h"

@interface ResetBindViewController ()

@end

@implementation ResetBindViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [_resetInfoButton defaultStyle];
}

- (void)viewWillAppear:(BOOL)animated {
  [self.navigationController.navigationBar setHidden:NO];
  [self.navigationController.navigationBar
      setBarTintColor:[UIColor colorWithRed:47 / 255.0f
                                      green:175 / 255.0f
                                       blue:98 / 255.0f
                                      alpha:1.0f]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (IBAction)resetInfo:(id)sender {
  NSString *uuid = [FCUUID uuidForDevice];
  NSLog(@"the uuid is %@", uuid);

  NSString *username = _usernameReset.text;
  NSString *password = _passwordReset.text;

  NSString *sig = [self
      md5:[NSString stringWithFormat:
                        @"%@%@%@iOS%@", uuid,
                        [username stringByAddingPercentEscapesUsingEncoding:
                                      NSUTF8StringEncoding],
                        password, uuid]];

  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:username forKey:@"username"];
  [userDefaults setObject:password forKey:@"password"];
  [userDefaults setObject:uuid forKey:@"uuid"];
  [userDefaults setObject:sig forKey:@"sig"];
  [userDefaults setBool:YES forKey:@"isBind"];

  UIStoryboard *mainStoryboard =
      [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  id viewController =
      [mainStoryboard instantiateViewControllerWithIdentifier:@"confirmPage"];
  [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)cacelAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma - mark md5
- (NSString *)md5:(NSString *)str {
  const char *cStr = [str UTF8String];
  unsigned char result[16];
  CC_MD5(cStr, strlen(cStr), result);
  return [NSString
      stringWithFormat:
          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
          result[0], result[1], result[2], result[3], result[4], result[5],
          result[6], result[7], result[8], result[9], result[10], result[11],
          result[12], result[13], result[14], result[15]];
}
@end
