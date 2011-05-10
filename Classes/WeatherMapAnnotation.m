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
}

@end
