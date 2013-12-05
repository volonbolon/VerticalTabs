//
//  FWKTabBarControllerDelegate.h
//  VerticalTabs
//
//  Created by Ariel Rodriguez on 04/12/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWKTabBarController;

@protocol FWKTabBarControllerDelegate <NSObject>

@optional
- (BOOL)tabBarController:(FWKTabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController;

- (void)tabBarController:(FWKTabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController;

@end
