//
//  FWKVerticalTabBar.m
//  VerticalTabs
//
//  Created by Ariel Rodriguez on 04/12/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import "FWKVerticalTabBar.h"
#import "FWKVerticalTabBarDelegate.h"

const CGFloat kButtonHeight = 100.0;

NSString * const kButtonKey = @"buttonKey";
NSString * const kTabBarItemKey = @"tabBarItemKey";

@interface FWKProxyContent : NSObject
@property (strong) UITabBarItem *tabBarItem;
@property (strong) UIButton *button;

+ (instancetype)proxyContentWithTabBarItem:(UITabBarItem *)tabBarItem
                                    button:(UIButton *)button;
@end

@implementation FWKProxyContent

+ (instancetype)proxyContentWithTabBarItem:(UITabBarItem *)tabBarItem
                                    button:(UIButton *)button {
    
    FWKProxyContent *content = [FWKProxyContent new];
    [content setTabBarItem:tabBarItem];
    [content setButton:button];
    
    return content;
    
}

@end


@interface FWKVerticalTabBar ()
@property (nonatomic, strong) NSDictionary *proxy;
- (IBAction)buttonTapped:(id)sender;
@end

@implementation FWKVerticalTabBar
- (void)layoutSubviews {
    
    [self setBackgroundColor:[UIColor greenColor]];
    
    CGSize boundsSize = [self bounds].size;
    CGFloat verticalOffset = (boundsSize.height-([[self items] count]*kButtonHeight))/2.0;
    
    NSMutableDictionary *mutableProxy = [[NSMutableDictionary alloc] init];
    
    for ( UITabBarItem *item in [self items] ) {
        
        @autoreleasepool {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:[item title]
                    forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor]
                         forState:UIControlStateSelected];
            [button setFrame:CGRectMake(0, verticalOffset, boundsSize.width, kButtonHeight)];
            verticalOffset += kButtonHeight;
            
            [button addTarget:self
                       action:@selector(buttonTapped:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            
            FWKProxyContent *content = [FWKProxyContent proxyContentWithTabBarItem:item
                                                                            button:button];
            
            [mutableProxy setObject:content
                             forKey:[item title]];
            
        }
        
    }
    
    [self setProxy:mutableProxy];
    
    [self setSelectedItem:[[self items] objectAtIndex:0]];
    
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
        
    if ( ![_selectedItem isEqual:selectedItem] ) {
        
        FWKProxyContent *content = [[self proxy] objectForKey:[_selectedItem title]];
        
        UIButton *currentButton = [content button];
        [currentButton setSelected:NO];
        
        content = [[self proxy] objectForKey:[selectedItem title]];
        UIButton *button = [content button];
        [button setSelected:YES];
        
        _selectedItem = selectedItem;
        
    }
    
}

- (IBAction)buttonTapped:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    NSString *buttonTitle = [button titleForState:UIControlStateNormal];
    
    UITabBarItem *selectedTabBarItem = [[[self proxy] objectForKey:buttonTitle] tabBarItem];
    
    if ( selectedTabBarItem != nil && [self delegate] != nil ) {
        
        [[self delegate] tabBar:self
                  didSelectItem:selectedTabBarItem];
        
    }
    
}
@end
