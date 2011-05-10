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

@synthesize titleField, zipCodeField, location;

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
	}
	else if(textField == self.zipCodeField) {
		self.location.zipCode = self.zipCodeField.text;
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

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
											   target:self
											   action:@selector(done)] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// Display location to edit or message if location is nil
	if (location.title) {
		self.title = location.title;
		self.titleField.text = location.title;
		self.zipCodeField.text = location.zipCode;
	} else {
		self.title = @"Add Location";
		self.titleField.text = nil;
		self.zipCodeField.text = nil;
	}
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	self.location.title = self.titleField.text;
	self.location.zipCode = self.zipCodeField.text;
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
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

@end

