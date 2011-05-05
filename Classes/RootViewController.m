//
//  RootViewController.m
//  WeatherMap
//
//  Created by David Ballard on 4/28/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import "RootViewController.h"
#import "WeatherMapAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import <YAJLiOS/YAJL.h>

@implementation RootViewController

@synthesize mapView, responseData, forecasts;
//@synthesize annotationList;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Weather Map";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" 
																			 style:UIBarButtonItemStyleBordered 
																			target:self 
																			 action:@selector(showLocationTable)] autorelease];
	/*
	NSString *baseURl = @"http://free.worldweatheronline.com/feed/weather.ashx";
    NSString *urlStr = [baseURl stringByAppendingFormat:@"?q=%d&format=json&num_of_days=5&key=%@&includeLocation=yes", 
                        22030,
                        @"b86e961893190455111404"];
    NSURL *url = [NSURL URLWithString:urlStr];
	*/
	

	myLocation.latitude = 38.84;
	myLocation.longitude = -77.35;
	// Set Location to Fairfax
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = myLocation.latitude; //38.84;
    newRegion.center.longitude = myLocation.longitude; //-77.35;
    newRegion.span.latitudeDelta = 0.50;
    newRegion.span.longitudeDelta = 0.50;
	//newRegion.span.latitudeDelta = 20;
	//newRegion.span.longitudeDelta = 20;
	
    [self.mapView setRegion:newRegion animated:YES];
	if ([CLLocationManager locationServicesEnabled]) {
		CLLocationManager *manager = [[CLLocationManager alloc] init];
		manager.delegate = self;
		[manager startUpdatingLocation];
	}
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
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

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
	
	// if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
	
	// Create a pin object
	MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: [annotation title]];
	if (pin == nil) {
		MKPinAnnotationView *pinView = [[[MKPinAnnotationView alloc]
											   initWithAnnotation:annotation reuseIdentifier: [annotation title]] autorelease];
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.animatesDrop = YES;
		pinView.canShowCallout = YES;

		UIButton *calloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[calloutButton addTarget:self action:@selector(calloutTapped) forControlEvents:UIControlEventTouchUpInside];
		pinView.rightCalloutAccessoryView = calloutButton;
		return pinView;
	} else {
		pin.annotation = annotation;
	}
	
	return pin;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error loading: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *json = [responseData yajl_JSON];
    self.forecasts = [json valueForKeyPath:@"data.weather"];
	[self placeAnnotations];
}

- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation {
	
    NSLog(@"location = %@", newLocation);   
    NSString *baseURl = @"http://free.worldweatheronline.com/feed/weather.ashx";
    NSString *urlStr = [baseURl stringByAppendingFormat:@"?q=%f,%f&format=json&num_of_days=5&key=%@", 
                        newLocation.coordinate.latitude, 
                        newLocation.coordinate.longitude,
                        @"b86e961893190455111404"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    [manager stopUpdatingLocation];
}

#pragma mark -
#pragma mark RootViewController actions

-(IBAction) showLocationTable {
	NSLog(@"Load Zipcode List");
}

- (void) placeAnnotations {
	// URL for location based annotation
	/*
	 NSString *baseURl = @"http://free.worldweatheronline.com/feed/weather.ashx";
	 NSString *urlStr = [baseURl stringByAppendingFormat:@"?q=%f,%f&format=json&num_of_days=5&key=%@", 
														myLocation.latitude, 
														myLocation.longitude,
														@"b86e961893190455111404"];
	 NSURL *url = [NSURL URLWithString:urlStr];
	 NSURLRequest *request = [NSURLRequest requestWithURL:url];
	 NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
	 */
	
	// Basic Annotation creation to be replaced by PList locations
	WeatherMapAnnotation *newAnnotation = [WeatherMapAnnotation alloc];
	CLLocationCoordinate2D location;
	location.latitude = 38.84;
	location.longitude = -77.35;
	[newAnnotation setCoordinate: location];
	[newAnnotation setTitle: @"Zipcode/Title"];
	NSDictionary *forecast = [forecasts objectAtIndex:0];
	NSLog(@"forecast = %@", [forecasts objectAtIndex:0]);
	NSString *weather = [NSString stringWithFormat:@"%@°F - %@°F: %@",
						 [forecast objectForKey:@"tempMinF"],
						 [forecast objectForKey:@"tempMaxF"],
						 [[forecast valueForKeyPath:@"weatherDesc.value"] objectAtIndex:0]];
	[newAnnotation setSubtitle: weather];
	[mapView addAnnotation: newAnnotation];
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

