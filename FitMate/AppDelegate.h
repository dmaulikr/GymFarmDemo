//
//  AppDelegate.h
//  FitMate
//
//  Created by Troy Simon on 7/17/14.
//  Copyright (c) 2014 Gym Farm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"

#import "GymFarmLib.h"

#define HIDEKEYBOARD @"hidekeyboard"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign) MMDrawerController * drawerController;


-(void) closeDrawer;
-(void) openLeftDrawer;
-(void) openRightDrawer;


@end
