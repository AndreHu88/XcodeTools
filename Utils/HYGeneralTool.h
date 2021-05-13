//
//  HYGeneralTool.h
//  Home
//
//  Created by Jack on 2021/5/13.
//  Copyright © 2021 jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYGeneralTool : NSObject

/** byte格式化为 B KB MB 方便流量查看  */
+ (NSString *)formatByte:(CGFloat)byte;

/** 删除某一路径下的所有文件 */
+ (void)clearFileWithPath:(NSString *)path;

/** share text */
+ (void)shareText:(NSString *)text formVC:(UIViewController *)vc;

/** share Image */
+ (void)shareImage:(UIImage *)image formVC:(UIViewController *)vc;

/** share URL */
+ (void)shareURL:(NSURL *)url formVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
