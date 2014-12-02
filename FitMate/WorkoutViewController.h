//
//  WorkoutViewController.h
//  Planet
//
//  Created by troy simon on 11/18/14.
//  Copyright (c) 2014 troy simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"
#import "PulsingHaloLayer.h"

@interface WorkoutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *workoutTitle;
@property (weak, nonatomic) IBOutlet UILabel *workoutDistance;
@property (weak, nonatomic) IBOutlet UILabel *workoutMeters;

@property (weak, nonatomic) IBOutlet UILabel *workoutTime;
@property (weak,nonatomic) IBOutlet UILabel *workoutGym;

@property (weak, nonatomic) IBOutlet UICountingLabel *workoutCo;
@property (nonatomic, weak) IBOutlet UIImageView *beaconView;
@property (nonatomic, weak) PulsingHaloLayer *halo;

@end
