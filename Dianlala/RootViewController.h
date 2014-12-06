//
//  ConfirmViewController.h
//  Dianlala
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"
#import "ValidFaileViewController.h"
#import "ValidSuccessViewController.h"

@interface RootViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
      NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (strong,nonatomic) UIActivityIndicatorView *Indicator;
@property (strong,nonatomic) NSString *Info;
@end
