//
//  Weather1EditorViewController.m
//  Weather1
//
//  Created by Brice Gnikpo on 5/4/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import "LocationEditorView.h"
#import "Location.h"

@implementation LocationEditorView

@synthesize titleField, zipCodeField, location, editingLocation;

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.titleField.text = location.title;
	self.zipCodeField.text = location.zipCode;
	//self.titleField.text = [editingLocation valueForKey:@"Title"];
	//self.zipCodeField.text = [editingLocation valueForKey:@"Zipcode"];
}

- (IBAction)done {
	[self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	if(textField == self.titleField) {
		self.location.title = self.titleField.text;
		//[editingLocation setValue:self.titleField.text forKey:@"Title"];
	}
	else if(textField == self.zipCodeField) {
		self.location.zipCode = self.zipCodeField.text;
		//[editingLocation setValue:self.zipCodeField.text forKey:@"Zipcode"];
	}
	
}


#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	self.location.title = self.titleField.text;
	self.location.zipCode = self.zipCodeField.text;
	//NSMutableDictionary *newLocation = [[[NSMutableDictionary alloc] init] autorelease];
	//[newLocation setObject:self.titleField.text forKey:@"Title"];
	//[newLocation setObject:self.zipCodeField.text forKey:@"Zipcode"];
	//[editingLocation setDictionary:newLocation];
	//NSLog(@"%@, %@", [editingLocation valueForKey:@"Title"], [editingLocation valueForKey:@"Zipcode"]);
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
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

@end

