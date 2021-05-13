//
//  HYAppInfoTool.h
//  Home
//
//  Created by Jack on 2021/5/13.
//  Copyright © 2021 jackie@youzan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AuthorizationStatus) {
    AuthorizationStatusNotDetermined,
    AuthorizationStatusRestricted,
    AuthorizationStatusDenied,
    AuthorizationStatusAuthorized
};

@interface HYAppInfoTool : NSObject

+ (NSString *)appName;

/**
 DeviceInfo：获取当前设备的 用户自定义的别名，例如：库克的 iPhone 9
 @return 当前设备的 用户自定义的别名，例如：库克的 iPhone 9
 */
+ (NSString *)iphoneName;

/**
 DeviceInfo：获取当前设备的 系统名称，例如：iOS 13.1
 @return 当前设备的 系统名称，例如：iOS 13.1
 */
+ (NSString *)iphoneSystemVersion;

+ (NSString *)bundleIdentifier;

+ (NSString *)bundleVersion;

+ (NSString *)bundleShortVersionString;

+ (NSString *)iphoneType;

+ (BOOL)isIPhoneXSeries;

+ (BOOL)isIpad;

+ (CLAuthorizationStatus)locationAuthority;

+ (AuthorizationStatus)cameraAuthority;

+ (AuthorizationStatus)audioAuthority;

+ (AuthorizationStatus)photoAuthority;

+ (AuthorizationStatus)addressAuthority;

+ (AuthorizationStatus)calendarAuthority;

+ (AuthorizationStatus)remindAuthority;

+ (AuthorizationStatus)bluetoothAuthority;


+ (BOOL)isSimulator;

/** 获取设备当前网络IP地址 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/** 获取当前UUID */
+ (NSString *)uuid;

/** 打开当前应用设置 */
+ (void)openAppSetting;

@end

NS_ASSUME_NONNULL_END
