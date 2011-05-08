//
//  RootViewController.h
//  WeatherMap
//
//  Created by David Ballard on 4/28/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "LocationEditorView.h"
#import "WeatherMapAppDelegate.h"

@interface LocationTable : UITableViewController {
	NSMutableArray *locationArray;
	LocationEditorView *locationEditor;
	UITableViewCell *nibLoadedCell;
	WeatherMapAppDelegate *weatherAppDelegate;
	Location *editLocation;
}

@property (nonatomic, retain) IBOutlet LocationEditorView *locationEditor;
@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;
@property (nonatomic, retain) Location *editLocation;

-(IBAction) handleAddTapped;

@end
