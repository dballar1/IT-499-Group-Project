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
#import "Location.h"
#import "LocationTable.h"
#import "WeatherMapAppDelegate.h"
#import "WeatherMapAnnotation.h"
#import "detailView.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	MKMapView *mapView;
	NSMutableArray *annotationList;
	LocationTable *locationTable;
	NSMutableArray *locationArray;
	NSMutableArray *forecasts;
	NSMutableArray *latLong;
	NSMutableArray *requestArray;
	detailView *weatherDetail;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray *annotationList;
@property (nonatomic, retain) IBOutlet LocationTable *locationTable;
@property (nonatomic, retain) NSMutableArray *forecasts;
@property (nonatomic, retain) NSMutableArray *latLong;
@property (nonatomic, retain) NSMutableArray *requestArray;
@property (nonatomic, retain) IBOutlet detailView *weatherDetail;

-(IBAction) showLocationTable;
-(void) createAnnotations;
-(void) removeAllAnnotations;

@end
