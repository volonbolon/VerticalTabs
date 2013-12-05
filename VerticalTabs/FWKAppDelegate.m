//
//  FWKAppDelegate.m
//  VerticalTabs
//
//  Created by Ariel Rodriguez on 04/12/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import "FWKAppDelegate.h"
#import "FWKTabBarController.h"
#import "FWKViewController.h"
#import "UIColor+RandomColor.h"


@implementation FWKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setWindow:window];
	
    FWKTabBarController *tabBarController = [FWKTabBarController new];
    
    [tabBarController setDelegate:self];
    
    [[self window] setRootViewController:tabBarController];
    [[self window] addSubview:[tabBarController view]];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    
    for ( NSUInteger n = 0; n < 5; n++ ) {
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"%d", n]
                                                                 image:nil
                                                         selectedImage:nil];
        FWKViewController *vc = [[FWKViewController alloc] init];
        [vc setTabBarItem:tabBarItem];
        [[vc view] setBackgroundColor:[UIColor randomColor]];
        [items addObject:vc];
        
    }
    
    [tabBarController setViewControllers:items];
	
	[[self window] makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - FWKTabBarControllerDelegate
- (void)tabBarController:(FWKTabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
    
    NSLog(@"%@", viewController);
    
}

- (BOOL)tabBarController:(FWKTabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    
    return ![[[viewController tabBarItem] title] isEqualToString:@"1"];
    
}

@end
