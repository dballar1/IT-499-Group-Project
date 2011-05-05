//
//  WeatherMapAnnotation.h
//  WeatherMap
//
//  Created by David Ballard on 5/5/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WeatherMapAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
}
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
//- (void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate;
@end
