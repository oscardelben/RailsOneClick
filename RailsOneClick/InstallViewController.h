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

@interface InstallViewController : NSViewController

@property (retain) IBOutlet NSButton *installButton;
@property (retain) IBOutlet NSProgressIndicator *progressIndicator;
@property (retain) AppController *appController;

- (IBAction)installRuby:(id)sender;

@end
