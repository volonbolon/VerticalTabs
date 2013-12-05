//
//  FWKVerticalTabBar.h
//  VerticalTabs
//
//  Created by Ariel Rodriguez on 04/12/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FWKVerticalTabBarDelegate;

@interface FWKVerticalTabBar : UIView
@property (nonatomic, weak) NSObject<FWKVerticalTabBarDelegate> *delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UITabBarItem *selectedItem;
@end
