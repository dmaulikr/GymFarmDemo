//
//  WorkoutViewController.m
//  Planet
//
//  Created by troy simon on 11/18/14.
//  Copyright (c) 2014 troy simon. All rights reserved.
//

#import "WorkoutViewController.h"
#import "AppDelegate.h"

@interface WorkoutViewController ()
{
    NSString *lastEquipment;
    PulsingHaloLayer *layer;
    NSDate *timeOnEquipment;
}
@end

@implementation WorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedStatusNotification:)
                                                 name:GYMFARM_NOTIF_EQUIOMENT_UPDATE
                                               object:nil];
    
    layer = [PulsingHaloLayer layer];
    self.halo = layer;
    
    self.halo.position = self.beaconView.center;
    layer.radius = 120;
    self.halo.backgroundColor = [[UIColor greenColor] CGColor];
    
    [self.view.layer insertSublayer:self.halo below:self.beaconView.layer];
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]])
    {
        NSLog(@"This device does not support monitoring beacon regions");
    }
}


-(void)receivedStatusNotification:(NSNotification *)notification
{
    NSDictionary *beaconDict = (NSDictionary *)[notification object];
    
    long timeInterval = [[beaconDict objectForKey:@"gym_time"] longValue];
    long seconds = lroundf(timeInterval); // Modulo (%) operator below needs int or long
    
    long mins = seconds % 3600 / 60;
    long secs = seconds % 60;

    
    if (beaconDict == nil)
        return;

    self.workoutTime.text = [NSString stringWithFormat:@"%2.0fm %2.0fs", (float)mins,(float)secs];

    // Empty notification, return
    
    self.workoutDistance.text = [beaconDict objectForKey:@"beacon_proximity"];
    
    self.workoutMeters.text = [NSString stringWithFormat:@"%2.2f meters",[[beaconDict objectForKey:@"accuracy"] floatValue]];
    
    if ([[beaconDict objectForKey:@"beacon_proximity"] isEqualToString:@"immediate"])
        layer.radius = 20;
    else if ([[beaconDict objectForKey:@"beacon_proximity"] isEqualToString:@"near"])
        layer.radius = 60;
    else if ([[beaconDict objectForKey:@"beacon_proximity"] isEqualToString:@"far"])
        layer.radius = 120;
    else if ([[beaconDict objectForKey:@"beacon_proximity"] isEqualToString:@"unknown"])
        layer.radius = 0;

    self.workoutGym.text = [[beaconDict objectForKey:@"beacon_name"] uppercaseString];
    
    NSArray *searchFor = (NSArray *)[beaconDict objectForKey:@"beacon_tags"] ;
    
    NSString *foundEquipmnt = [[self stripDownArray:searchFor] uppercaseString];
    
    // If new beacon is closets, reset the beacon display
    if (![lastEquipment isEqualToString:foundEquipmnt])
    {
        timeOnEquipment = [NSDate date];
        lastEquipment = foundEquipmnt;
        self.workoutTitle.text = foundEquipmnt;
        [self.workoutCo countFromCurrentValueTo:(arc4random() % 50)];
    }
    
}

-(NSString *) stripDownArray:(NSArray *) a
{
    NSMutableString *name = [[NSMutableString alloc] init];
    
    [name setString:@""];
    
    for(int i = 0; i < [a count]; i++)
    {
        if ( (![[a objectAtIndex:i] isEqualToString:@"welcome"]) && (![[a objectAtIndex:i] isEqualToString:@"equipment"]) )
            [name appendString:[a objectAtIndex:i]];
    }
    
    return [name capitalizedString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
