//
//  FWKAppDelegate.h
//  VerticalTabs
//
//  Created by Ariel Rodriguez on 04/12/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWKTabBarControllerDelegate.h"

@interface FWKAppDelegate : UIResponder <UIApplicationDelegate, FWKTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
