//
//  ConfirmViewController.h
//  Dianlala
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmViewController : UIViewController
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(weak, nonatomic) IBOutlet UILabel *studentNumberLable;

- (IBAction)confirmSuccess:(id)sender;
@end
