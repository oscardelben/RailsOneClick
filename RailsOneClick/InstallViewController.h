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

@interface InstallViewController : NSViewController

@property (retain) IBOutlet NSButton *installButton;
@property (retain) IBOutlet NSProgressIndicator *progressIndicator;
@property (retain) IBOutlet NSTextField *statusLabel;
@property (retain) AppController *appController;
@property (retain) LogWindowController *logWindowController;

- (IBAction)installRuby:(id)sender;
- (IBAction)openLogWindow:(id)sender;

@end
