//
//  ConfirmViewController.h
//  Dianlala
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    NSLog(@"%f",self.view.frame.size.height);
    //对button的配置
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    [scanButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scanButton setFrame:CGRectMake((self.view.frame.size.width-120)/2, (420/568)*self.view.frame.size.height, 120, 40)];
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    
    //对label的配置
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-290)/2, 40, 290, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [self.view addSubview:labIntroudction];
    
    //对指示器的设置
    _Indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_Indicator setFrame:CGRectMake((self.view.frame.size.width-30)/2,(self.view.frame.size.height-30)/2 , 30, 30)];
    [_Indicator hidesWhenStopped];
    [self.view addSubview:_Indicator];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, (100/640)*self.view.frame.size.height, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    upOrdown = NO;
    num =0;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

-(void)backAction
{
    [timer invalidate];
    [self performSegueWithIdentifier:@"rootGoQR" sender:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}

- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(20,110,280,280);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [_Indicator startAnimating];
    
    NSLog(@"%@",stringValue);
    
    NSUserDefaults *userDeault = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"sname":[userDeault objectForKey:@"username"],@"sid":[userDeault objectForKey:@"password"],@"os":@"iOS",@"pid":[userDeault objectForKey:@"uuid"],@"sig":[userDeault objectForKey:@"sig"]};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:stringValue parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [timer invalidate];
        [_Indicator stopAnimating];

        if(1==1){
            _Info = [NSString stringWithFormat:@""];
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }else{
            _Info = @"该手机已签到，请勿重复签到";
            [self performSegueWithIdentifier:@"signFaile" sender:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        _Info = @"网络故障，请重试";
        [timer invalidate];
        [_Indicator stopAnimating];
        [self performSegueWithIdentifier:@"signFaile" sender:self];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"signSuccess"]){
        ValidSuccessViewController *destViewController = segue.destinationViewController;
        destViewController.Infolabel.text = @"";
    }else if([segue.identifier isEqualToString:@"signFaile"]){
        ValidFaileViewController *destViewController = segue.destinationViewController;
        destViewController.InfoLabel.text = _Info;
    }else{
    
    }
}


@end
