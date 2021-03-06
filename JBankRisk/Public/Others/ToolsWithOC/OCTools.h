//
//  OCTools.h
//  JBankRisk
//
//  Created by caohouhong on 16/12/29.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCTools : NSObject
//获取设备IP
+(NSString *)getIPAddress;

//获取可用内存
+ (long long)getAvailableMemorySize;

//获取已使用内存
+ (double)getUsedMemory;

//手机型号
+(NSString *)getIPhoneType;

//Log打印显示更改
+ (NSString *)logDic:(NSDictionary *)dic;
//芝麻信用url转换
+ (NSString *)URLEncodedStringWithUrl:(NSString *)url;

+(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end
