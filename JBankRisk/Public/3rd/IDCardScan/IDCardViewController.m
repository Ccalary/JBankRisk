//
//  IDCardViewController.m
//  idcard
//
//  Created by hxg on 16-4-10.
//  Copyright (c) 2016年 林英伟. All rights reserved.
//
@import MobileCoreServices;
@import ImageIO;
#import "IDCardViewController.h"
#import "IdInfo.h"
#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.width
#define UIRATE SCREEN_WIDTH/375.0

@interface IDCardViewController ()
{
    
    NSString *userName;
    NSString *userCodeNum;
    NSString *userAddress;
    UIButton *confiremBtn;
}
@end

@implementation IDCardViewController
@synthesize verify = _verify;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

static Boolean init_flag = false;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    /*******************/
    if (!init_flag)
    {
        const char *thePath = [[[NSBundle mainBundle] resourcePath] UTF8String];
        int ret = EXCARDS_Init(thePath);
        if (ret != 0)
        {
            NSLog(@"Init Failed!ret=[%d]", ret);
        }
        
        init_flag = true;
    }
    /******************/
    [self setTitle:@"身份自动识别"];
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    
}


//- (void)closeAction
//{
//    [self removeCapture];
//    [self dismissViewControllerAnimated: YES completion:nil];
//    if(init_flag){
//        EXCARDS_Done();
//        init_flag = false;
//    }
//}


-(void) viewDidUnload
{
    if (_buffer != NULL)
    {
        free(_buffer);
        _buffer = NULL;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initCapture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}


#pragma mark - Capture

- (void)initCapture
{
    // init capture manager
    _capture = [[Capture alloc] init];
    
    _capture.delegate = self;
    _capture.verify = self.verify;
    
    // set video streaming quality
    // AVCaptureSessionPresetHigh   1280x720
    // AVCaptureSessionPresetPhoto  852x640
    // AVCaptureSessionPresetMedium 480x360
    _capture.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    //kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange
    //kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
    //kCVPixelFormatType_32BGRA
    [_capture setOutPutSetting:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]];
    
    // AVCaptureDevicePositionBack
    // AVCaptureDevicePositionFront
    [_capture addVideoInput:AVCaptureDevicePositionBack];
    
    [_capture addVideoOutput];
    [_capture addVideoPreviewLayer];
    
//    CGRect layerRect = self.view.bounds;
    CGRect layerRect = CGRectMake((SCREEN_WIDTH - 220*UIRATE)/2, (SCREEN_HEIGHT - 350*UIRATE)/2, 220*UIRATE, 350*UIRATE);
    
    [[_capture previewLayer] setOpaque: 0];
    [[_capture previewLayer] setBounds:layerRect];
    [[_capture previewLayer] setPosition:CGPointMake( CGRectGetMidX(layerRect), CGRectGetMidY(layerRect))];
    
    // create a view, on which we attach the AV Preview layer
    
    CGFloat barHeigth = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    _cameraView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (barHeigth + 44))];
    [[_cameraView layer] addSublayer:[_capture previewLayer]];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 355*UIRATE, SCREEN_WIDTH, 40*UIRATE)];
    tipsLabel.text = @"请将身份证正面位置竖直位于扫描区域";
    tipsLabel.font = [UIFont systemFontOfSize:12*UIRATE];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [_cameraView addSubview:tipsLabel];
    
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 400*UIRATE,SCREEN_WIDTH, 80*UIRATE)];
    holdView.backgroundColor = [UIColor whiteColor];
    [_cameraView addSubview:holdView];
    
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, 40*UIRATE, SCREEN_WIDTH, 0.5*UIRATE)];
    divider.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    [holdView addSubview:divider];
    
    UILabel *nameText = [[UILabel alloc]initWithFrame:CGRectMake(10*UIRATE, 0, 100*UIRATE, 40*UIRATE)];
    nameText.backgroundColor = [UIColor clearColor];
    nameText.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    nameText.font = [UIFont systemFontOfSize:15*UIRATE];
    nameText.text = @"姓名";
    [holdView addSubview:nameText];
    
    UILabel *codeText = [[UILabel alloc]initWithFrame:CGRectMake(10*UIRATE, 40*UIRATE, 100*UIRATE, 40*UIRATE)];
    codeText.backgroundColor = [UIColor clearColor];
    codeText.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    codeText.font = [UIFont systemFontOfSize:15*UIRATE];
    codeText.text = @"身份证号";
    [holdView addSubview:codeText];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*UIRATE, 0, SCREEN_WIDTH - 100*UIRATE, 40*UIRATE)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor =[UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:15*UIRATE];
    [holdView addSubview:nameLabel];
    
    codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100*UIRATE, 40*UIRATE, SCREEN_WIDTH - 100*UIRATE, 40*UIRATE)];
    codeLabel.backgroundColor = [UIColor clearColor];
    codeLabel.textColor =[UIColor blackColor];
    codeLabel.font = [UIFont systemFontOfSize:15*UIRATE];
    [holdView addSubview:codeLabel];
    
    confiremBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 345*UIRATE)/2, 500*UIRATE + 64, 345*UIRATE, 44*UIRATE)];
    [confiremBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_grayred_345x44"] forState:UIControlStateNormal];
    [confiremBtn setTitle:@"确认" forState:UIControlStateNormal];
    confiremBtn.userInteractionEnabled = NO;
    [confiremBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confiremBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confiremBtn];
    
    UILabel *infoErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 544*UIRATE + 64, SCREEN_WIDTH/2, 30*UIRATE)];
    infoErrorLabel.text = @"识别有误";
    infoErrorLabel.textAlignment = NSTextAlignmentRight;
    infoErrorLabel.font = [UIFont systemFontOfSize:12*UIRATE];
    [self.view addSubview:infoErrorLabel];
    
    UIButton *againBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 544*UIRATE + 64, 70*UIRATE, 30*UIRATE)];
    againBtn.titleLabel.font = [UIFont systemFontOfSize:12*UIRATE];
    [againBtn setTitle:@"重新识别>" forState:UIControlStateNormal];
    [againBtn setTitleColor:[UIColor colorWithRed:60/255.0 green:170/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
    [againBtn addTarget:self action:@selector(againBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:againBtn];
    
    // add the view we just created as a subview to the View Controller's view
    [self.view addSubview: _cameraView];
    [self.view sendSubviewToBack:_cameraView];
    
    // start !
    [self performSelectorInBackground:@selector(startCapture) withObject:nil];
}

- (void)removeCapture
{
    [_capture.captureSession stopRunning];
    [_cameraView removeFromSuperview];
    _capture     = nil;
    _cameraView  = nil;
}

- (void)startCapture
{
    //@autoreleasepool
    {
        [[_capture captureSession] startRunning];
    }
}

#pragma mark - Capture Delegates
- (void)idCardRecognited:(IdInfo*)idInfo
{
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        
        if (idInfo.name != nil)
        {
            userName = idInfo.name;
            [nameLabel setText:[NSString stringWithFormat:@"%@", idInfo.name]];
        }
        
        if (idInfo.code != nil)
        {
            userCodeNum = idInfo.code;
            [codeLabel setText:[NSString stringWithFormat:@"%@", idInfo.code]];
        }
        
        if (idInfo.address != nil)
        {
            userAddress = idInfo.address;
        }
        
        [confiremBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_red_345x44"] forState:UIControlStateNormal];
        confiremBtn.userInteractionEnabled = YES;
    });
    
    [_capture.captureSession stopRunning];
    
}

//重新识别
- (void)againBtnAction
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [nameLabel setText:@""];
        [codeLabel setText:@""];
        
        [confiremBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_grayred_345x44"] forState:UIControlStateNormal];
        confiremBtn.userInteractionEnabled = NO;
    });
    
    [[_capture captureSession] startRunning];
}

//确认信息
- (void)confirmBtnAction
{
    [self removeCapture];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.block){
        self.block(userName,userCodeNum,userAddress);
    }
    if(init_flag){
        EXCARDS_Done();
        init_flag = false;
    }
}


@end
