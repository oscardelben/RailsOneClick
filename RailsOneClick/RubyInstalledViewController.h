//
//  RubyInstalledViewController.h
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RubyInstalledViewController : NSViewController

@property (unsafe_unretained) IBOutlet NSButton *finderButton;
@property (unsafe_unretained) IBOutlet NSButton *terminalButton;

- (IBAction)openTerminalWindow:(id)sender;
- (IBAction)openFinder:(id)sender;

- (IBAction)openRailsGuides:(id)sender;
- (IBAction)openRailsDocs:(id)sender;
- (IBAction)openRailsOneClick:(id)sender;

@end
