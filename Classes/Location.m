//
//  Weather1.m
//  Weather1
//
//  Created by Brice Gnikpo on 5/3/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize title, zipCode;

- (id)initWithTitle:(NSString *)newTitle zipCode:(NSString *)newZipCode {
	self = [super init];
	if(nil != self) {
		self.title = newTitle;
		self.zipCode = newZipCode;
	}
	return self;
}

- (void) dealloc {
	self.title = nil;
	self.zipCode = nil;
	[super dealloc];
}

@end