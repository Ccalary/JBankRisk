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
@end
