//
//  QRViewController.h
//  Dianlala
//
//  Created by MexiQQ on 14/11/26.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *QRView;
@property (weak, nonatomic) IBOutlet UILabel *ScaningState;
- (IBAction)StartScaning:(id)sender;
- (IBAction)StopScaning:(id)sender;

@end
