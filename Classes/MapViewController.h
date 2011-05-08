//
//  RootViewController.h
//  WeatherMap
//
//  Created by David Ballard on 4/28/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "LocationTable.h"
#import "WeatherMapAppDelegate.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	MKMapView *mapView;
	NSMutableData *responseData;
	NSArray *forecasts;
	NSMutableArray *annotationList;
	CLLocationCoordinate2D myLocation;
	LocationTable *locationTable;
	WeatherMapAppDelegate *weatherAppDelegate;
}

@property (nonatomic, retain) IBOutlet LocationTable *locationTable;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSArray *forecasts;
@property (nonatomic, retain) NSMutableArray *annotationList;
//@property (nonatomic, retain) WeatherMapAppDelegate *weatherAppDelegate;

-(IBAction) showLocationTable;
-(void) placeAnnotations;
-(void) calloutTapped;

@end
