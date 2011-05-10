//
//  WelcomeScreenView.h
//  WeatherMap
//
//  Created by David Ballard on 5/10/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface WelcomeScreenView : UIViewController {
	UIButton *welcomeButton;
	MapViewController *map;
}

@property (nonatomic, retain) IBOutlet UIButton *welcomeButton;
@property (nonatomic, retain) IBOutlet MapViewController *map;

-(IBAction) continueTapped;

@end
