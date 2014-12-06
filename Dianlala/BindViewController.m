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
    NSString *sig = [self md5:[NSString stringWithFormat:@"%@%@%@iOS%@",uuid,[username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],password,uuid]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:username forKey:@"username"];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults setObject:uuid forKey:@"uuid"];
    [userDefaults setObject:sig forKey:@"sig"];
    [userDefaults setBool:YES forKey:@"isBind"];
    
    [self performSegueWithIdentifier:@"confirmBind" sender:self];
}


#pragma -mark md5
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

@end
