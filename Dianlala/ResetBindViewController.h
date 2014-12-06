//
//  ResetBindViewController.h
//  Dianlala
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCUUID.h"
#import "UIButton+Bootstrap.h"
#import <CommonCrypto/CommonDigest.h>

@interface ResetBindViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameReset;
@property (weak, nonatomic) IBOutlet UITextField *passwordReset;
@property (weak, nonatomic) IBOutlet UIButton *resetInfoButton;
@property (weak, nonatomic) IBOutlet UIView *toobar;
- (IBAction)resetInfo:(id)sender;
@end
