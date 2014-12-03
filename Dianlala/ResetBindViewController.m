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
    [self.navigationController.navigationBar setHidden:YES];
    [_toobar setBackgroundColor:[UIColor colorWithRed:47/255.0f green:175/255.0f blue:98/255.0f alpha:1.0f]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resetInfo:(id)sender {
    NSString *uuid = [FCUUID uuidForDevice];
    NSLog(@"the uuid is %@",uuid);
    
    NSString *username = _usernameReset.text;
    NSString *password = _passwordReset.text;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:username forKey:@"username"];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults setObject:uuid forKey:@"uuid"];
    //[self performSegueWithIdentifier:@"confirmBind" sender:self];
}
@end
