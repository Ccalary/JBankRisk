//
//  OCTools.m
//  JBankRisk
//
//  Created by caohouhong on 16/12/29.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

#import "OCTools.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

#import <sys/sysctl.h>  
#import <mach/mach.h>
#import "sys/utsname.h"


@implementation OCTools

// Get IP Address
+(NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                
                NSString *ifaName = [NSString stringWithUTF8String:temp_addr->ifa_name];
                
                NSString* getedAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
                NSString* mask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_netmask)->sin_addr)];
                NSString* gateway = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_dstaddr)->sin_addr)];
                
                NSLog(@"ifaName:%@--address:%@--mask:%@--gateway:%@",ifaName,address,mask,gateway);
                
                if([ifaName isEqualToString:@"en0"]) {//无线网
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }else if([ifaName isEqualToString:@"pdp_ip0"]){//3g、4g网
                    address = getedAddress;
                }
                
                
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

//获取可用内存
+ (long long)getAvailableMemorySize
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

//获取已使用内存
+ (double)getUsedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size;
}

//手机型号
+ (NSString*)getIPhoneType
 {
     struct utsname systemInfo;
     uname(&systemInfo);
     NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
     //iPhone
     if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
     if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
     if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
     if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
     if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
     if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
     if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
     if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
     if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
     if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
     if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
     if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
     if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
     if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
     if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
     if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
     if ([deviceString isEqualToString:@"iPhone9,1"] || [deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
     if ([deviceString isEqualToString:@"iPhone9,2"] || [deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
     if ([deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
     if ([deviceString isEqualToString:@"iPhone10,2"] || [deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
     if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";
     
     return deviceString;
 }



// log NSSet with UTF8
// if not ,log will be \Uxxx
// log 打印样式更改
+ (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

+ (NSString *)URLEncodedStringWithUrl:(NSString *)url {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)url,NULL,(CFStringRef) @"!'();:@&=+$,%#[]|",kCFStringEncodingUTF8));
    return encodedString;
}

//银行卡号格式
+(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 24) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}  


@end
