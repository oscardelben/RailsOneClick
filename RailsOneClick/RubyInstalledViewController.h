//
//  RubyInstalledViewController.h
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RubyInstalledViewController : NSViewController <NSTabViewDelegate, NSTableViewDataSource>

@property (retain) NSMutableArray *apps;

- (IBAction)openTerminalWindow:(id)sender;
- (IBAction)openFinder:(id)sender;

@end
