//
//  WeatherMapAnnotation.m
//  WeatherMap
//
//  Created by David Ballard on 5/5/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import "WeatherMapAnnotation.h"
#import <YAJLiOS/YAJL.h>

@implementation WeatherMapAnnotation

@synthesize coordinate, title, subtitle;

- (id)initWithName:(NSString *) name latitude: (double) latitude longitude: (double) longitude {
	self = [super init];
	if(nil != self) {
		self.title = name;
		coordinate.latitude = latitude;
		coordinate.longitude = longitude;
	}
	return self;
	//NSLog(@"%@", forecasts);
	//NSDictionary *forecast = [forecasts objectAtIndex:0];
	//NSLog(@"%@°F - %@°F: %@", [forecast objectForKey:@"tempMinF"], [forecast objectForKey:@"tempMaxF"],
	//	  [[forecast valueForKeyPath:@"weatherDesc.value"] objectAtIndex:0]);
	//annotation.subtitle = [NSString stringWithFormat:@"%@°F - %@°F: %@",
	//					   [forecast objectForKey:@"tempMinF"], [forecast objectForKey:@"tempMaxF"],
	//					   [[forecast valueForKeyPath:@"weatherDesc.value"] objectAtIndex:0]];
    /*
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv",
				 [zipcode stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSArray *listItems = [locationString componentsSeparatedByString:@","];
    double latitude = 0.0;
    double longitude = 0.0;
    if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
        latitude = [[listItems objectAtIndex:2] doubleValue];
        longitude = [[listItems objectAtIndex:3] doubleValue];
		coordinate.latitude = latitude;
		coordinate.longitude = longitude;
    } else {
        //Error handling
    }*/
	//return self;
}

@end
