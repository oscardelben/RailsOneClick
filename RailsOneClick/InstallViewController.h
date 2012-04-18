//
//  InstallViewController.h
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <dispatch/dispatch.h>
#import "AppController.h"
#import "LogWindowController.h"

@interface InstallViewController : NSViewController <NSAlertDelegate>

@property (retain) IBOutlet NSTextField *statusLabel;
@property (retain) AppController *appController;
@property (retain) LogWindowController *logWindowController;
@property (unsafe_unretained) IBOutlet NSButton *checkPrerequisitesButton;
@property (unsafe_unretained) IBOutlet NSButton *installButton;
@property (unsafe_unretained) IBOutlet NSButton *logButton;

- (IBAction)checkPrerequisites:(id)sender;
- (IBAction)installRuby:(id)sender;
- (IBAction)openLogWindow:(id)sender;

@end
