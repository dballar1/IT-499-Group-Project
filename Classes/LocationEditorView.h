//
//  Weather1EditorViewController.h
//  Weather1
//
//  Created by Brice Gnikpo on 5/4/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Location;

@interface LocationEditorView : UIViewController <UITextFieldDelegate> {
	UITextField *titleField;
	UITextField *zipCodeField;
	Location *location;
	NSMutableDictionary *editingLocation;
}

@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *zipCodeField;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSMutableDictionary *editingLocation;

- (IBAction)done;

@end
