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
	NSArray *locationArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

