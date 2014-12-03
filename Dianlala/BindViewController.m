//
//  ViewController.m
//  Dianlala
//
//  Created by MexiQQ on 14/11/26.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "BindViewController.h"

@interface BindViewController ()

@end

@implementation BindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    [_toolbar setBackgroundColor:[UIColor colorWithRed:47/255.0f green:175/255.0f blue:98/255.0f alpha:1.0f]];

    [_loginButton defaultStyle];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    NSString *uuid = [FCUUID uuidForDevice];
    NSLog(@"the uuid is %@",uuid);
    
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:username forKey:@"username"];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults setObject:uuid forKey:@"uuid"];
    [self performSegueWithIdentifier:@"confirmBind" sender:self];
}
@end
