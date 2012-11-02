//
//  ClassAppDelegate.m
//  ImageGalleryDemo
//
//  Created by wenbo on 11/2/12.
//  Copyright (c) 2012 wenbo. All rights reserved.
//

#import "ClassAppDelegate.h"

#import "ClassViewController.h"

@implementation ClassAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[ClassViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
