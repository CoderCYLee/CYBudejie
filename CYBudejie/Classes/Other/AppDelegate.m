//
//  AppDelegate.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/1.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 3D Touch
#ifdef __IPHONE_9_0
    [self createShortcutItems];
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[MainViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
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

/**
 
 typedef NS_ENUM(NSInteger, UIApplicationShortcutIconType) {
 UIApplicationShortcutIconTypeCompose,
 UIApplicationShortcutIconTypePlay,
 UIApplicationShortcutIconTypePause,
 UIApplicationShortcutIconTypeAdd,
 UIApplicationShortcutIconTypeLocation,
 UIApplicationShortcutIconTypeSearch,
 UIApplicationShortcutIconTypeShare,
 UIApplicationShortcutIconTypeProhibit       NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeContact        NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeHome           NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeMarkLocation   NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeFavorite       NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeLove           NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeCloud          NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeInvitation     NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeConfirmation   NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeMail           NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeMessage        NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeDate           NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeTime           NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeCapturePhoto   NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeCaptureVideo   NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeTask           NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeTaskCompleted  NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeAlarm          NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeBookmark       NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeShuffle        NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeAudio          NS_ENUM_AVAILABLE_IOS(9_1),
 UIApplicationShortcutIconTypeUpdate         NS_ENUM_AVAILABLE_IOS(9_1)
 } NS_ENUM_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;
 
 */

#ifdef __IPHONE_9_0
/** 创建3D Touch选项 */
- (void)createShortcutItems {
    
    // 最简单的形式
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"item1" localizedTitle:@"item1_title"];
    
    // 可以自定义的选项
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"item2" localizedTitle:@"item2title" localizedSubtitle:@"item2sub" icon:icon2 userInfo:nil];
    
    
    // 使用自定义的图片定义选项
    UIApplicationShortcutIcon * icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"delete"];
    UIApplicationShortcutItem * item3 = [[UIApplicationShortcutItem alloc]initWithType:@"item3"
                                                                        localizedTitle:@"Item3"
                                                                     localizedSubtitle:@"item3"
                                                                                  icon:icon3
                                                                              userInfo:nil];
    
    // 响应到APP端
    [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3];
}
#endif

@end
