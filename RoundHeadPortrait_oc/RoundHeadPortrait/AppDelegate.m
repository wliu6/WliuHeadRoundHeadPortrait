//
//  AppDelegate.m
//  RoundHeadPortrait
//
//  Created by 66 on 15/8/14.
//  Copyright (c) 2015年 w66. All rights reserved.
//
// 约束分析--layoutsubviews
////FIXME: if width != height执行下边的code
//NSLog(@"%@", NSStringFromCGRect(self.frame));
//if (self.frame.size.width != self.frame.size.height) {
//    for (NSLayoutConstraint *constraint in self.superview.constraints) {
//        if ([constraint.secondItem isEqual:self]) {
//
//        }
//    }
//    CGFloat lengthOfSide = [self w6_CornerRadiusWithSize:self.frame.size];
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, lengthOfSide, lengthOfSide);
//}
//return;
//
//
////    NSLog(@"%@", self.superview.constraints);
//for (NSLayoutConstraint *constraint in self.superview.constraints) {
//    //        NSLog(@"\n%@\n%@\n", constraint.firstItem, constraint.secondItem);
//    if ([constraint.secondItem isEqual:self]) {
//        NSLog(@"%@\n-%ld\n-%ld", constraint, constraint.firstAttribute, constraint.secondAttribute);// second attribute 是把头像view当做第一视角处理的
//
//        //            if (constraint.firstAttribute == NSLayoutAttributeBottom) {
//        //                NSLog(@"first--%f", constraint.multiplier);
//        //            }
//        //            if (constraint.secondAttribute == NSLayoutAttributeBottomMargin) {
//        //                NSLog(@"second--%f", constraint.multiplier);
//        //            }
//    }
//}
////    NSLog(@"%@", self.constraints);
////    for (NSLayoutConstraint *constraint in self.constraints) {
////        NSLog(@"%f", constraint.constant);
////    }
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
