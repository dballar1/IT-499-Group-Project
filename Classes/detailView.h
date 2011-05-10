//
//  detailView.h
//  weather_final
//
//  Created by Alex Litwack on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <YAJLiOS/YAJL.h>

@interface detailView: UITableViewController <CLLocationManagerDelegate> {
	NSMutableData *responseData;
	NSArray *forecasts;
	UITableViewCell *nibLoadedCell;
	CLLocation *incomeLocation;
}

@property (nonatomic, retain) IBOutlet CLLocation *incomeLocation;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSArray *forecasts;
@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;

@end