//
//  FWKVerticalTabBarDelegate.h
//  VerticalTabs
//
//  Created by Ariel Rodriguez on 04/12/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWKVerticalTabBar;

@protocol FWKVerticalTabBarDelegate <NSObject>

@required
- (void)tabBar:(FWKVerticalTabBar *)tabBar
 didSelectItem:(UITabBarItem *)item;

@end
