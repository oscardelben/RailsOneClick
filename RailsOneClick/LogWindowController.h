//
//  LogWindowController.h
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/15/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LogWindowController : NSWindowController

@property (retain) IBOutlet NSTextView *textView;
@property (retain) NSMutableString *buffer;

- (void)resetTextView;
- (void)appendString:(NSString *)aString;

@end
