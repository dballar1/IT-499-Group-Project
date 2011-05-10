//
//  RootViewController.m
//  WeatherMap
//
//  Created by David Ballard on 4/28/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import "LocationTable.h"

@implementation LocationTable

#pragma mark -
#pragma mark View lifecycle

@synthesize locationEditor, nibLoadedCell, editLocation, locationArray;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Set title and right bar button to add button
	self.title = @"Locations";
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																	target:self
																	action:@selector(handleAddTapped)] autorelease];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	// If table item was added or edited, update table display
	if (editLocation) {
		NSIndexPath *updatedPath = [NSIndexPath	indexPathForRow: [locationArray indexOfObject: editLocation] inSection: 0];
		NSArray *updatedPaths = [NSArray arrayWithObject:updatedPath];
		[self.tableView reloadRowsAtIndexPaths:updatedPaths withRowAnimation:NO];
		editLocation = nil;
	}
	[self.tableView reloadData];
}


-(IBAction) handleAddTapped {
	Location *location = [[Location alloc] init];
	editLocation = location;
	locationEditor.location = editLocation;
	[self.navigationController pushViewController:locationEditor animated:YES];
	
	//update UITableView (in background) with new member
	[locationArray addObject:editLocation];
	NSIndexPath *locationPath = [NSIndexPath indexPathForRow:[locationArray count]-1 inSection:0];
	NSArray *locationPaths = [NSArray arrayWithObject:locationPath];
	[self.tableView insertRowsAtIndexPaths:locationPaths withRowAnimation:NO];
	[location release];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	// Save only when returning to map view
	if (!editLocation) {
		NSMutableArray *saveArray = [[NSMutableArray alloc] init];
		for (Location *location in locationArray) {
			NSDictionary *locationDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: location.title, @"Title", 
								  location.zipCode, @"Zipcode", nil];
			[saveArray addObject: locationDictionary];
			[locationDictionary release];
		}
		[(WeatherMapAppDelegate *)[[UIApplication sharedApplication] delegate] saveData:saveArray];
		[saveArray release];
	}
}
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
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [locationArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"LocationTableCell" owner:self options:NULL];
		cell = nibLoadedCell;
	}
    
	// Configure the cell.
	Location *location = [[Location alloc] init];
	location = [locationArray objectAtIndex:indexPath.row];
	UILabel *titleLabel = (UILabel*) [cell viewWithTag:1];
	titleLabel.text = location.title;
	UILabel *zipCodeLabel = (UILabel*) [cell viewWithTag:2];
	zipCodeLabel.text = location.zipCode;
		
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		[locationArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	editLocation = [locationArray objectAtIndex:indexPath.row];
	locationEditor.location = editLocation;
	[self.navigationController pushViewController:locationEditor animated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end

