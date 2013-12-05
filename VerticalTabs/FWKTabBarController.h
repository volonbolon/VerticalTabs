//
//  FWKTabBarController.h
//  VerticalTabs
//
//  Created by Ariel Rodriguez on 04/12/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWKVerticalTabBarDelegate.h"

@class FWKVerticalTabBar;
@protocol FWKTabBarControllerDelegate;

@interface FWKTabBarController : UIViewController <FWKVerticalTabBarDelegate>

@property (nonatomic, weak) NSObject<FWKTabBarControllerDelegate> *delegate;
@property (nonatomic, strong, readonly) FWKVerticalTabBar *tabBar;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *moreViewController;
@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;

@end
