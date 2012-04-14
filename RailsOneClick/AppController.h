//
//  AppController.h
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppController : NSObject

@property (retain) IBOutlet NSView *view;
@property (retain) NSViewController *currentViewController;

- (void)rubyInstalled;

@end
