//
//  AppDelegate.m
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/8/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SettingsViewController.h"
#import "HistoryTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    MainViewController* mainController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    SettingsViewController* settingController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    
    HistoryTableViewController* historyController = [[HistoryTableViewController alloc] initWithNibName:@"HistoryTableViewController" bundle:nil];
    
    
    
    UINavigationController *mainNavigation = [[UINavigationController alloc] initWithRootViewController:mainController];
    
    UINavigationController *settingNavigation = [[UINavigationController alloc] initWithRootViewController:settingController];
    
    UINavigationController *historyNavigation = [[UINavigationController alloc] initWithRootViewController:historyController];
    
    NSArray* controllers = [NSArray arrayWithObjects: mainNavigation, settingNavigation, historyNavigation, nil];
    self.tabBarController.viewControllers = controllers;
    
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:227 / 255.0 green:154 / 255.0 blue:41/ 255.0 alpha: 1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont systemFontOfSize:20]}];
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
