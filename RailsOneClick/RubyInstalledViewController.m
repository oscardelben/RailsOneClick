//
//  RubyInstalledViewController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "RubyInstalledViewController.h"
#import "RailsApp.h"

@interface RubyInstalledViewController ()

@end

@implementation RubyInstalledViewController

@synthesize apps;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        self.apps = [RailsApp all];
    }
    
    return self;
}

- (IBAction)openTerminalWindow:(id)sender
{
    NSString *script = @"cd ~/Documents/rails_one_click; export PATH=~/Documents/rails_one_click/ruby/bin:$PATH; clear";
    NSString *apple_script = [NSString stringWithFormat:@"tell application \"Terminal\" to do script \"%@\"", script];
    
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource:apple_script];
    [as executeAndReturnError:nil];
}

- (IBAction)openFinder:(id)sender
{
    [[NSWorkspace sharedWorkspace] selectFile:@"~/Documents/rails_one_click/" inFileViewerRootedAtPath:nil];
}


#pragma mark -
#pragma mark NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [apps count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{

    if ([[aTableColumn identifier] isEqualToString:@"name"]) {
        return [[apps objectAtIndex:rowIndex] name]; // todo: return name
    }
    
    return nil;
}

@end
