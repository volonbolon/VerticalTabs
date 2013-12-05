//
//  FWKTabBarController.m
//  VerticalTabs
//
//  Created by Ariel Rodriguez on 04/12/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import "FWKTabBarController.h"
#import "FWKVerticalTabBar.h"
#import "FWKTabBarControllerDelegate.h"

@interface FWKTabBarController ()
@property (nonatomic, strong, readwrite) FWKVerticalTabBar *tabBar;

@end

@implementation FWKTabBarController

- (void)loadView {
    
    CGRect applicationFrame = [[UIScreen mainScreen] bounds];
    
    if ( UIInterfaceOrientationIsLandscape([self interfaceOrientation] ) ) {
        
        applicationFrame = CGRectMake(applicationFrame.origin.y, applicationFrame.origin.x, applicationFrame.size.height, applicationFrame.size.width);
        
    }
    
    UIView *container = [[UIView alloc] initWithFrame:applicationFrame];
    [container setBackgroundColor:[UIColor redColor]];
    
    FWKVerticalTabBar *tabBar = [[FWKVerticalTabBar alloc] initWithFrame:CGRectMake(0, 0, 100, applicationFrame.size.height)];
    [self setTabBar:tabBar];
    [tabBar setDelegate:self];
    [container addSubview:tabBar];

    [self setView:container];
    
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    _viewControllers = [viewControllers copy];
    
    NSMutableArray *mutableItems = [[NSMutableArray alloc] initWithCapacity:[viewControllers count]];
    if ( [self tabBar] != nil ) {
        
        CGRect viewBounds = [[self view] bounds];
        CGSize tabBarSize = [[self tabBar] bounds].size;
        CGRect vcBounds = CGRectMake(tabBarSize.width, viewBounds.origin.y, viewBounds.size.width-tabBarSize.width, viewBounds.size.height);
        
        for ( UIViewController *vc in [self viewControllers] ) {
            
            [mutableItems addObject:[vc tabBarItem]];
            [self addChildViewController:vc];
            
            [[vc view] setFrame:vcBounds];
            
            [vc didMoveToParentViewController:self];
            
        }
        
        [[self tabBar] setItems:mutableItems];
        
    }
    
    if ( [_viewControllers count] > 0 ) {
        
        _selectedViewController = [_viewControllers objectAtIndex:0];
        _selectedIndex = 0;
        
        [[self view] addSubview:[_selectedViewController view]];
        
    }
    
}


- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    
    if ( ![_selectedViewController isEqual:selectedViewController] ) {
        
        __block NSInteger selectedIndex = NSNotFound;
        [[self viewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if ( [selectedViewController isEqual:(UIViewController *)obj] ) {
                
                selectedIndex = idx;
                *stop = YES;
                
            }
            
        }];
        
        if ( selectedIndex != NSNotFound ) {
            
            [self setSelectedIndex:selectedIndex];
            
        }
        
    }
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    if ( selectedIndex != _selectedIndex && selectedIndex < [[self viewControllers] count] ) {
        
        UIViewController *currentViewController = _selectedViewController;
        UIViewController *selectedViewController = [[self viewControllers] objectAtIndex:selectedIndex];
        
        NSObject<FWKTabBarControllerDelegate> *delegate = [self delegate];
        if ( [delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)] ) {
            
            if ( [delegate tabBarController:self
                 shouldSelectViewController:selectedViewController] ) {
                
                [[self tabBar] setSelectedItem:[selectedViewController tabBarItem]];
                
                __weak FWKTabBarController *weakSelf = self;
                [self transitionFromViewController:currentViewController
                                  toViewController:selectedViewController
                                          duration:0
                                           options:UIViewAnimationOptionLayoutSubviews
                                        animations:NULL
                                        completion:^(BOOL finished) {
                                            
                                            __strong FWKTabBarController *strongSelf = weakSelf;
                                            
                                            _selectedViewController = selectedViewController;
                                            _selectedIndex = selectedIndex;
                                            
                                            if ( strongSelf != nil ) {
                                                
                                                if ( [delegate respondsToSelector:@selector(tabBar:didSelectItem:)] ) {
                                                    
                                                    [delegate tabBarController:strongSelf
                                                       didSelectViewController:selectedViewController];
                                                    
                                                }
                                                
                                            }
                                            
                                        }];
                
            }
            
        }
        
    }
    
}

#pragma mark - FWKVerticalTabBarDelegate
- (void)tabBar:(FWKVerticalTabBar *)tabBar
 didSelectItem:(UITabBarItem *)item {

    
    NSString *selectedItemTitle = [item title];
    
    __block NSInteger selectedIndex = NSNotFound;
    [[self viewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ( [selectedItemTitle isEqualToString:[[(UIViewController *)obj tabBarItem] title]] ) {
            
            selectedIndex = idx;
            *stop = YES;
            
        }
        
    }];
    
    if ( selectedIndex != NSNotFound ) {
        
        [self setSelectedIndex:selectedIndex];
        
    }

}


@end
