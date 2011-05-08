//
//  Weather1.h
//  Weather1
//
//  Created by Brice Gnikpo on 5/3/11.
//  Copyright 2011 George Mason University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location : NSObject {
	NSString *title;
	NSString *zipCode;
}

- (id)initWithTitle:(NSString *)newTitle zipCode:(NSString *)newZipCode;
			

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *zipCode;

@end
