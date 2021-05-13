//
//  HYGeneralTool.m
//  Home
//
//  Created by Jack on 2021/5/13.
//  Copyright © 2021 jack All rights reserved.
//

#import "HYGeneralTool.h"

@implementation HYGeneralTool

+ (void)clearFileWithPath:(NSString *)path {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *files = [fm subpathsAtPath:path];
    for (NSString *file in files) {
        
        NSError *error;
        NSString *filePath = [path stringByAppendingPathComponent:file];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if (!error) {
                NSLog(@"remove file: %@", file);
            }
        }
    }
}

+ (NSString *)formatByte:(CGFloat)byte{
    
    double convertedValue = byte;
    int multiplyFactor = 0;
    NSArray *tokens = [NSArray arrayWithObjects:@"B",@"KB",@"MB",@"GB",@"TB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    return [NSString stringWithFormat:@"%4.2f%@",convertedValue, [tokens objectAtIndex: multiplyFactor]]; 
}

+ (void)shareText:(NSString *)text formVC:(UIViewController *)vc{
    [self share:text formVC:vc];
}

//share image
+ (void)shareImage:(UIImage *)image formVC:(UIViewController *)vc{
    [self share:image formVC:vc];
}

//share url
+ (void)shareURL:(NSURL *)url formVC:(UIViewController *)vc{
    [self share:url formVC:vc];
}

+ (void)share:(id)object formVC:(UIViewController *)vc{
    
    if (!object) {
        return;
    }
    NSArray *objectsToShare = @[object];//support NSString、NSURL、UIImage

    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];

    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPad"]) {
        
        if ( [controller respondsToSelector:@selector(popoverPresentationController)] ) {
            controller.popoverPresentationController.sourceView = vc.view;
            controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
            controller.popoverPresentationController.sourceRect = CGRectMake(vc.view.frame.size.width/2.0, vc.view.frame.size.height/2.0, 1.0, 1.0);
        }
        
        [vc presentViewController:controller animated:YES completion:nil];
    }
    else{
        [vc presentViewController:controller animated:YES completion:nil];
    }
}

@end
