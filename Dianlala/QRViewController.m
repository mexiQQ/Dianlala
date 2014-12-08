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
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setHidden:YES];
    [_resetButton defaultStyle];
    [_QRView setBackgroundColor:[UIColor colorWithRed:33.0/255.0f green:166.0/255.0f blue:96.0/255.0f alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7

- (IBAction)StartScaning:(id)sender {
    
    if(IOS7){
        [self performSegueWithIdentifier:@"scaning" sender:self];
    }
}

@end
