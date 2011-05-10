//
//  WeatherMapAppDelegate.h
//  WeatherMap
//
//  Created by David Ballard on 4/28/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherMapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
	NSMutableArray *locationArray;
	NSMutableArray *forecasts;
	NSMutableArray *latLong;
	NSMutableArray *requestArray;
	NSMutableData *responseData;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet NSMutableArray *forecasts;
@property (nonatomic, retain) IBOutlet NSMutableArray *latLong;
@property (nonatomic, retain) IBOutlet NSMutableArray *requestArray;

- (NSArray *) loadData;
- (NSMutableArray *) getLocations;
- (void) getConnectionData;
- (void) saveData:(NSMutableArray *) locations;

@end

