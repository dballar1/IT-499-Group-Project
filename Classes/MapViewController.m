//
//  RootViewController.m
//  WeatherMap
//
//  Created by David Ballard on 4/28/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <YAJLiOS/YAJL.h>

@implementation MapViewController

@synthesize mapView, locationTable, annotationList, forecasts, latLong;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Map";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" 
																			 style:UIBarButtonItemStyleBordered 
																			target:self 
																			 action:@selector(showLocationTable)] autorelease];
	// Center region to Kansas
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 39.30;
    newRegion.center.longitude = -95.80;
	newRegion.span.latitudeDelta = 40;
	newRegion.span.longitudeDelta = 40;
    [self.mapView setRegion:newRegion animated:YES];
	mapView.delegate = self;
	if ([CLLocationManager locationServicesEnabled]) {
		CLLocationManager *manager = [[CLLocationManager alloc] init];
		manager.delegate = self;
		[manager startUpdatingLocation];
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	locationArray = [(WeatherMapAppDelegate *)[[UIApplication sharedApplication] delegate] getLocations];
	//NSLog(@"ViewController: locationArray-%d", [locationArray count]);
	forecasts = [(WeatherMapAppDelegate *)[[UIApplication sharedApplication] delegate] forecasts];
	//NSLog(@"ViewController: forecasts-%d", [forecasts count]);	
	latLong = [(WeatherMapAppDelegate *)[[UIApplication sharedApplication] delegate] latLong];
	//NSLog(@"ViewController: latLong-%d", [latLong count]);
	[self removeAllAnnotations];
	annotationList = nil;
	annotationList = [[NSMutableArray alloc] init];
	[self createAnnotations];
	//NSLog(@"ViewController: annotationList-%d", [annotationList count]);
	[mapView addAnnotations:annotationList];

}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

#pragma mark -
#pragma mark Delegate Methods

- (MKAnnotationView *) mapView: (MKMapView *) map viewForAnnotation: (id<MKAnnotation>) annotation {
	// if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
	
	// Create a pin object
	MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: annotation.title];
	if (!pin) {
		MKPinAnnotationView *pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
																		reuseIdentifier: annotation.title] autorelease];
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.animatesDrop = YES;
		pinView.canShowCallout = YES;
		UIButton *calloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[calloutButton addTarget:self
						  action:@selector(calloutTapped)
				forControlEvents:UIControlEventTouchUpInside];
		pinView.rightCalloutAccessoryView = calloutButton;
		return pinView;
	} else {
		pin.annotation = annotation;
	}
	return pin;
}

#pragma mark -
#pragma mark MapViewController actions

-(void) createAnnotations {
	NSLog(@"Forecast Objects: %d, Location Objects: %d", [forecasts count], [latLong count]);
	NSMutableArray *temps = [[NSMutableArray alloc] init];
	for (NSDictionary *forecast in forecasts) {
		[temps addObject:[[forecast valueForKey:@"temp_F"] objectAtIndex:0]];
	}
	NSMutableArray *coords = [[NSMutableArray alloc] init];
	for (NSDictionary *loc in latLong) {
		CLLocation *location = [[CLLocation alloc] initWithLatitude:[[[loc valueForKey:@"latitude"] objectAtIndex:0] doubleValue]
														  longitude:[[[loc valueForKey:@"longitude"] objectAtIndex:0] doubleValue]];
		[coords addObject: location];
		[location release];
	}
	for (int i = 0; i < [locationArray count]; i++) {
		CLLocation *location = [coords objectAtIndex:i];
		WeatherMapAnnotation *annote = [[WeatherMapAnnotation alloc] initWithName:[[locationArray objectAtIndex:i] title] 
																		 latitude:location.coordinate.latitude
																		longitude:location.coordinate.longitude];
		annote.subtitle = [NSString stringWithFormat:@"%@°F", [temps objectAtIndex:i]];
		[annotationList addObject:annote];
		NSLog(@"Title = %@, Subtitle = %@, Lat = %f, Long = %f", annote.title, annote.subtitle, annote.coordinate.latitude, annote.coordinate.longitude);
		[annote release];
	}
}

-(void)removeAllAnnotations {
	//Get the current user location annotation.
	id userAnnotation = mapView.userLocation;
	
	//Remove all added annotations
	[mapView removeAnnotations:mapView.annotations]; 
	
	// Add the current user location annotation again.
	if(userAnnotation != nil) {
		[mapView addAnnotation:userAnnotation];
	}
}

-(IBAction) showLocationTable {
	locationTable.locationArray = locationArray;
	[self.navigationController pushViewController:locationTable animated:YES];
}

-(void) calloutTapped {
	NSLog(@"Callout Button Tapped");
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[mapView dealloc];
    [super dealloc];
}

@end

