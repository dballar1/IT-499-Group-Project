//
//  WeatherMapAppDelegate.m
//  WeatherMap
//
//  Created by David Ballard on 4/28/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import <YAJLiOS/YAJL.h>
#import "WeatherMapAppDelegate.h"
#import "MapViewController.h"
#import "Location.h"

@implementation WeatherMapAppDelegate

@synthesize window, navigationController, forecasts, latLong;

#pragma mark -
#pragma mark Locations from File

- (NSArray *) loadData {
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"locations.plist"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath: path]) {
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"plist"];
		[fileManager copyItemAtPath:bundle toPath:path error:&error];
	}
	NSArray *locations = [[[NSArray alloc] initWithContentsOfFile: path] autorelease];
	return locations;
}

-(NSMutableArray *) getLocations {
	// Initialize and load location array from app delegate > plist
	locationArray = [[NSMutableArray alloc] init];
	NSArray *loadedArray = [[[NSArray alloc] init] autorelease];
	loadedArray = [self loadData];
	for (NSMutableDictionary *locationDictionary in loadedArray) {
		// Create a location array from NSDictionary
		Location *location = [[Location alloc] init];
		location.title = [locationDictionary valueForKey:@"Title"];
		location.zipCode = [locationDictionary valueForKey:@"Zipcode"];
		[locationArray addObject:location];
		[location release];
	}
	return locationArray;
}

-(void) getConnectionData {
	for (Location *location in locationArray) {
		forecasts = [[NSMutableArray alloc] init];
		latLong = [[NSMutableArray alloc] init];
		NSString *baseURl = @"http://free.worldweatheronline.com/feed/weather.ashx";
		NSString *urlStr = [baseURl stringByAppendingFormat:@"?q=%@&format=json&num_of_days=1&key=%@&includeLocation=yes", 
							location.zipCode, @"b86e961893190455111404"];
		NSURL *url = [NSURL URLWithString:urlStr];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[NSURLConnection connectionWithRequest:request delegate:self];
	}
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
	[forecasts addObject: [json valueForKeyPath:@"data.current_condition"]];
	[latLong addObject: [json valueForKeyPath:@"data.nearest_area"]];
	[responseData release];
}

- (void) saveData:(NSMutableArray *) locations {
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"locations.plist"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath: path]) {
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"plist"];
		[fileManager copyItemAtPath:bundle toPath:path error:&error];
	}
	[locations writeToFile:path atomically:YES];
	[self getLocations];
	[self getConnectionData];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [self getLocations];
	[self getConnectionData];
	
	// Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

