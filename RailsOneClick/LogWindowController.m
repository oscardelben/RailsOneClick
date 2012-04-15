//
//  LogWindowController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/15/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "LogWindowController.h"

@interface LogWindowController ()

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

- (void)resetTextView
{
    [textView setString:@""];
    self.buffer = [NSMutableString string];
}

// TODO: make it more readable/refactor
- (void)appendString:(NSString *)aString
{
    // if text view is not visible we save the string in a buffer
    if (textView) {
        
        NSMutableString *content = [NSMutableString string];
        
        // check if we need to add the buffer
        if ([buffer length] > 0) {
            [content appendString:buffer];
            // reset buffer
            buffer = [NSMutableString string];
        }
        
        [content appendString:aString];
        
        [[[textView textStorage] mutableString] appendString:content];
        
        [textView scrollPageDown:nil];
    } else {        
        [buffer appendString:aString];
    }
    
}


@end
