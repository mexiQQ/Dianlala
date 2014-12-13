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
    
    //因爲無法使用虛擬機測試二維碼，所以使用代碼佈局
    //对button的配置
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    [scanButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scanButton setFrame:CGRectMake((self.view.frame.size.width-120)/2, (420/(float)568)*self.view.frame.size.height, 120, 40)];
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    
    //对label的配置
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-290)/2, (40/(float)568)*self.view.frame.size.height, 290, 50)];
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
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, (100/(float)568)*self.view.frame.size.height, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-220)/2, (110/(float)568)*self.view.frame.size.height, 220, 2)];
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
        _line.frame = CGRectMake((self.view.frame.size.width-220)/2, (110/(float)568)*self.view.frame.size.height+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((self.view.frame.size.width-220)/2, (110/(float)568)*self.view.frame.size.height+2*num, 220, 2);
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
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSLog(@"%@",[userDeault objectForKey:@"sig"]);
    NSDictionary *parameters = @{@"sname":[[userDeault objectForKey:@"username"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"sid":[userDeault objectForKey:@"password"],@"os":@"iOS",@"pid":[userDeault objectForKey:@"uuid"],@"sig":[userDeault objectForKey:@"sig"]};
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:stringValue parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [timer invalidate];
        [_Indicator stopAnimating];

        NSArray *res = (NSArray *)responseObject;
        NSDictionary *re = (NSDictionary *)res[0];
        if(re.count == 3){
            NSString *tname = [re objectForKey:@"tname"];
            NSString *cname = [re objectForKey:@"cname"];
            _Info = [NSString stringWithFormat:@"您已经在%@老师的%@课上点名成功",[self UTF8_To_GB2312:tname],[self UTF8_To_GB2312:cname]];
            [self performSegueWithIdentifier:@"signSuccess" sender:self];
        }else if([[re objectForKey:@"result"] isEqualToString:@"1002"]){
            _Info = @"该手机已签到，请勿重复签到";
            [self performSegueWithIdentifier:@"signFaile" sender:self];

        }else{
            _Info = @"请求操时";
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
        destViewController.Info = _Info;
    }else if([segue.identifier isEqualToString:@"signFaile"]){
        ValidFaileViewController *destViewController = segue.destinationViewController;
        destViewController.Info = _Info;
    }else{
    
    }
}

#pragma mark -utf-8-gbk
- (NSString*)UTF8_To_GB2312:(NSString*)utf8string
{
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gb2312data = [utf8string dataUsingEncoding:encoding];
    return [[NSString alloc] initWithData:gb2312data encoding:encoding];
}

@end
