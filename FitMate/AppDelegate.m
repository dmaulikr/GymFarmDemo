//
//  AppDelegate.m
//  FitMate
//
//  Created by troy simon on 7/17/14.
//  Copyright (c) 2014 troy simon. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set your API key
    [[GymFarmLib sharedManager] setApplicationID:@"123-123-123-13123-12313-12312-123"];
    
    // Set the delegate
    [[GymFarmLib sharedManager] setDelegate:self];
    
    // Download the beacons that belong to the application
    [[GymFarmLib sharedManager] obtainBeacons];
    
    // Add an observer to receive the notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedStatusNotification:)
                                                 name:GYMFARM_NOTIF_BEACON_RANGE_UPDATE
                                               object:nil];
    
    // Override point for customization after application launch.
    return YES;
}


// Callback notification method
-(void)receivedStatusNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    for (NSString *beaconKey in userInfo)
    {
        
        NSDictionary *beaconDict = [userInfo objectForKey:beaconKey];
        
        NSArray *tags = [beaconDict objectForKey:GYMFARM_BEACON_RANGE_KEY_BEACON_TAGS];
        
        // If the beacons is for equipment
        if ([tags containsObject:@"equipment"])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:GYMFARM_NOTIF_EQUIOMENT_UPDATE object:beaconDict];
        }
    }
}

// Called from the Gym Farm library
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"You entered the region.");
}

// Called from the Gym Farm library
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"You exited the region.");
}

// Post a local notfication
-(void)sendLocalNotificationWithMessage:(NSString*)message {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// Called from the Gym Farm library
-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSString *message = @"No beacons Found";
    
        CLBeacon *nearestBeacon = beacons.firstObject;
        
        switch(nearestBeacon.proximity) {
            case CLProximityFar:
                message = @"You are far away from the beacon.";
                break;
            case CLProximityNear:
                message = @"You are near the beacon.";
                break;
            case CLProximityImmediate:
                message = @"You are in the immediate proximity of the beacon.";
                break;
            case CLProximityUnknown:
                return;
        }
    
    
   NSLog(@"Accuracy: %2.2f : %@ ",nearestBeacon.accuracy,message);
}

-(void) openRightDrawer
{
    [self.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

-(void) openLeftDrawer
{
    [self.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void) closeDrawer
{
    [self.drawerController closeDrawerAnimated:YES completion:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
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

@end
