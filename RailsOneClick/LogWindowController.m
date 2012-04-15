//
//  LogWindowController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/15/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "LogWindowController.h"

@interface LogWindowController ()
- (void)appendBuffer;
@end

@implementation LogWindowController

@synthesize textView;
@synthesize buffer;

- (id)initWithWindowNibName:(NSString *)windowNibName
{
    self = [super initWithWindowNibName:windowNibName];
    if (self) {
        self.buffer = [NSMutableString string];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self appendBuffer];
}

- (void)resetTextView
{
    [textView setString:@""];
    self.buffer = [NSMutableString string];
}

// TODO: make it more readable/refactor
- (void)appendString:(NSString *)aString
{
    // if text view is not visible we save the string in a buffer
    // if it is visible we check if we have something in the buffer to show
    if (textView) {
        [self appendBuffer];

        [[[textView textStorage] mutableString] appendString:aString];
        
        [textView scrollPageDown:nil];
    } else {        
        [buffer appendString:aString];
    }
    
}

- (void)appendBuffer
{
    if ([buffer length] > 0) {
        [[[textView textStorage] mutableString] appendString:buffer];
        buffer = [NSMutableString string];
    }
}
@end
