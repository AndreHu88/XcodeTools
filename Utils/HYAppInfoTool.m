//
//  HYAppInfoTool.m
//  Home
//
//  Created by Jack on 2021/5/13.
//  Copyright © 2021 jackie@youzan. All rights reserved.
//

#import "HYAppInfoTool.h"
#import <sys/utsname.h>
#import <CoreLocation/CLLocationManager.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>
#import <UIKit/UIKit.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>



#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation HYAppInfoTool

+ (NSString *)appName {
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    }
    return appName;
}

+ (NSString *)iphoneName {
    
    return [UIDevice currentDevice].name;
}

+ (NSString *)iphoneSystemVersion {
    
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)bundleIdentifier {
    
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)bundleVersion {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)bundleShortVersionString {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)iphoneType{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    
    return platform;
}

+ (BOOL)isIPhoneXSeries{
    
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [self getKeyWindow];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

+ (BOOL)isIpad{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPad"]) {
        return YES;
    }
    return NO;
}

+ (CLAuthorizationStatus)locationAuthority{
    
    NSString *authority = @"";
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];

    if ([CLLocationManager locationServicesEnabled]) {
        if (authStatus == kCLAuthorizationStatusNotDetermined) {
            authority = @"NotDetermined";
        }
        else if (authStatus == kCLAuthorizationStatusRestricted){
            authority = @"Restricted";
        }
        else if (authStatus == kCLAuthorizationStatusDenied){
            authority = @"Denied";
        }
        else if(authStatus == kCLAuthorizationStatusAuthorizedAlways){
            authority = @"Always";
        }
        else if(authStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
            authority = @"WhenInUse";
        }
    }
    else{
        authority = @"NoEnabled";
    }
    return authStatus;
}


+ (AuthorizationStatus)cameraAuthority{
    
    NSString *authority = @"";
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    
    AuthorizationStatus status = AuthorizationStatusNotDetermined;
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            authority = @"NotDetermined";
            status = AuthorizationStatusNotDetermined;
            break;
        case AVAuthorizationStatusRestricted:
            authority = @"Restricted";
            status = AuthorizationStatusRestricted;
            break;
        case AVAuthorizationStatusDenied:
            authority = @"Denied";
            status = AuthorizationStatusDenied;
            break;
        case AVAuthorizationStatusAuthorized:
            authority = @"Authorized";
            status = AuthorizationStatusAuthorized;
            break;
        default:
            break;
    }
    return status;
}

+ (AuthorizationStatus)audioAuthority{
    
    NSString *authority = @"";
    NSString *mediaType = AVMediaTypeAudio;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    
    AuthorizationStatus status = AuthorizationStatusNotDetermined;

    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            authority = @"NotDetermined";
            status = AuthorizationStatusNotDetermined;
            break;
        case AVAuthorizationStatusRestricted:
            authority = @"Restricted";
            status = AuthorizationStatusRestricted;
            break;
        case AVAuthorizationStatusDenied:
            authority = @"Denied";
            status = AuthorizationStatusDenied;
            break;
        case AVAuthorizationStatusAuthorized:
            authority = @"Authorized";
            status = AuthorizationStatusAuthorized;

            break;
        default:
            break;
    }
    return status;
}

+ (AuthorizationStatus)photoAuthority{
    
    NSString *authority = @"";
    AuthorizationStatus authStatus = AuthorizationStatusNotDetermined;

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0 //iOS 8.0以下使用AssetsLibrary.framework
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];

    switch (status) {
        case ALAuthorizationStatusNotDetermined: {
            //用户还没有选择
            authority = @"NotDetermined";
            authStatus = AuthorizationStatusNotDetermined;
        }
            break;
        case ALAuthorizationStatusRestricted: {
            //家长控制
            authority = @"Restricted";
            authStatus = AuthorizationStatusRestricted;
        }
            break;
        case ALAuthorizationStatusDenied: {
            //用户拒绝
            authority = @"Denied";
            authStatus = AuthorizationStatusDenied;
        }
            break;
        case ALAuthorizationStatusAuthorized: {
            //已授权
            authority = @"Authorized";
            authStatus = AuthorizationStatusAuthorized;
        }
            break;
        default:
            break;
    }
    
#else   //iOS 8.0以上使用Photos.framework
    PHAuthorizationStatus current = [PHPhotoLibrary authorizationStatus];
    switch (current) {
        case PHAuthorizationStatusNotDetermined: {
            //用户还没有选择(第一次)
            authority = @"NotDetermined";
            authStatus = AuthorizationStatusNotDetermined;
        }
            break;
        case PHAuthorizationStatusRestricted: {
            //家长控制
            authority = @"Restricted";
            authStatus = AuthorizationStatusRestricted;
        }
            break;
        case PHAuthorizationStatusDenied: {
            //用户拒绝
            authority = @"Denied";
            authStatus = AuthorizationStatusDenied;
        }
            break;
        case PHAuthorizationStatusAuthorized: {
            //已授权
            authority = @"Authorized";
            authStatus = AuthorizationStatusAuthorized;
        }
            break;
        default:
            break;
    }
#endif
    return authStatus;
}

+ (AuthorizationStatus)addressAuthority{
    
    NSString *authority = @"";
    AuthorizationStatus status = AuthorizationStatusNotDetermined;

    if (@available(iOS 9.0, *)) {
        
        /// iOS9.0之后
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (authStatus) {
            case CNAuthorizationStatusAuthorized:
                authority = @"Authorized";
                status = AuthorizationStatusAuthorized;
                break;
            case CNAuthorizationStatusDenied: {
                authority = @"Denied";
                status = AuthorizationStatusDenied;
            }
                break;
            case CNAuthorizationStatusNotDetermined: {
                authority = @"NotDetermined";
                status = AuthorizationStatusNotDetermined;

            }
                break;
            case CNAuthorizationStatusRestricted:
                authority = @"Restricted";
                status = AuthorizationStatusRestricted;
                break;
        }
    }
    else{
        
        /// iOS9.0之前
        ABAuthorizationStatus authorStatus = ABAddressBookGetAuthorizationStatus();
        switch (authorStatus) {
                
            case kABAuthorizationStatusAuthorized:
                authority = @"Authorized";
                status = AuthorizationStatusAuthorized;

                break;
            case kABAuthorizationStatusDenied: {
                authority = @"Denied";
                status = AuthorizationStatusDenied;

            }
                break;
            case kABAuthorizationStatusNotDetermined: {
                authority = @"NotDetermined";
                status = AuthorizationStatusNotDetermined;

            }
                break;
            case kABAuthorizationStatusRestricted:
                authority = @"Restricted";
                status = AuthorizationStatusRestricted;

                break;
            default:
                break;
        }
    }
    return status;
}

+ (AuthorizationStatus)calendarAuthority{
    
    NSString *authority = @"";
    AuthorizationStatus status = AuthorizationStatusNotDetermined;

    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (authStatus) {
        case EKAuthorizationStatusNotDetermined:
            authority = @"NotDetermined";
            status = AuthorizationStatusNotDetermined;
            break;
        case EKAuthorizationStatusRestricted:
            authority = @"Restricted";
            status = AuthorizationStatusRestricted;
            break;
        case EKAuthorizationStatusDenied:
            authority = @"Denied";
            status = AuthorizationStatusDenied;
            break;
        case EKAuthorizationStatusAuthorized:
            authority = @"Authorized";
            status = AuthorizationStatusAuthorized;
            break;
        default:
            break;
    }
    return status;
}

+ (AuthorizationStatus)remindAuthority{
    
    NSString *authority = @"";
    AuthorizationStatus status = AuthorizationStatusNotDetermined;

    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    switch (authStatus) {
        case EKAuthorizationStatusNotDetermined:
            authority = @"NotDetermined";
            status = AuthorizationStatusNotDetermined;
            break;
        case EKAuthorizationStatusRestricted:
            authority = @"Restricted";
            status = AuthorizationStatusRestricted;
            break;
        case EKAuthorizationStatusDenied:
            authority = @"Denied";
            status = AuthorizationStatusDenied;
            break;
        case EKAuthorizationStatusAuthorized:
            authority = @"Authorized";
            status = AuthorizationStatusAuthorized;
            break;
        default:
            break;
    }
    return status;
}


#pragma mark 设备是否模拟器
+ (NSString *)deviceIdentifier {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (BOOL)isSimulator {
    NSString *identifier = [self deviceIdentifier];
    return [identifier isEqualToString:@"i386"] || [identifier isEqualToString:@"x86_64"];
}

//获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    
    NSArray *searchArray = preferIPv4 ?
    @[  IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[  IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [[self class] getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
        address = addresses[key];
        if(address) *stop = YES;
    } ];
    return address ? address : @"0.0.0.0";
}

//获取所有相关IP信息
+ (NSDictionary *)getIPAddresses {
    
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface -> ifa_next) {
            
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr -> sin_family == AF_INET || addr->sin_family == AF_INET6)) {
                
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                }
                
                else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)uuid{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [ud objectForKey:@"UUID"];
    if (!uuid) {
        uuid = [[NSUUID UUID] UUIDString];
        [ud setObject:uuid forKey:@"UUID"];
        [ud synchronize];
    }
    return uuid;
}

+ (void)openAppSetting{
    
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        
        NSURL *url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (@available(iOS 10.0, *)) {
            
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
        else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - private
+ (UIWindow *)getKeyWindow{
    
    UIWindow *keyWindow = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        keyWindow = [[UIApplication sharedApplication].delegate window];
    }
    else{
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *window in windows) {
            if (!window.hidden) {
                keyWindow = window;
                break;
            }
        }
    }
    return keyWindow;
}

@end
