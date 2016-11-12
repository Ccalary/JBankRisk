//
//  IDCardViewController.h
//  idcard
//
//  Created by hxg on 16-4-10.
//  Copyright (c) 2016年 林英伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Capture.h"
typedef void(^IDCardBlock)(NSString *name, NSString *code);


@interface IDCardViewController : UIViewController<CaptureDelegate>
{
    Capture *_capture;
    UIView         *_cameraView;
    unsigned char* _buffer;
    
    UILabel *codeLabel; //身份证号
    UILabel *nameLabel; //姓名
   }
@property (weak, nonatomic) id<CaptureDelegate> delegate;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic)BOOL             verify;

@property (copy, nonatomic)IDCardBlock block;
@end
