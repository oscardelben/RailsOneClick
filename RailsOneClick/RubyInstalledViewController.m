//
//  RubyInstalledViewController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "RubyInstalledViewController.h"
#import "AppHelper.h"

@interface RubyInstalledViewController ()

@end

@implementation RubyInstalledViewController
@synthesize finderButton;
@synthesize terminalButton;


- (void)awakeFromNib
{
    [AppHelper changeButtonColor:finderButton color:[NSColor whiteColor] alternate:NO];
    [AppHelper changeButtonColor:finderButton color:[NSColor blackColor] alternate:YES];
    [AppHelper changeButtonColor:terminalButton color:[NSColor whiteColor] alternate:NO];
    [AppHelper changeButtonColor:terminalButton color:[NSColor blackColor] alternate:YES];
}

// TODO: this doesn't work if you open new windows!
- (NSString *)terminalScript
{
    NSString *script = @"cd ~/Documents/rails_one_click; export PATH=~/Documents/rails_one_click/ruby/bin:$PATH; clear";
    
    return [NSString stringWithFormat:@"tell application \"Terminal\" to do script \"%@\"\n" \
            @"tell application \"Terminal\" to activate",
            script];
}


- (IBAction)openTerminalWindow:(id)sender
{
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource:[self terminalScript]];
    [as executeAndReturnError:nil];
    
}

- (IBAction)openFinder:(id)sender
{
    [[NSWorkspace sharedWorkspace] selectFile:@"~/Documents/rails_one_click/" inFileViewerRootedAtPath:nil];
}

- (void)openURL:(NSString *)url
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
}

- (IBAction)openRailsGuides:(id)sender
{
    [self openURL:@"http://guides.rubyonrails.org/"];
}

- (IBAction)openRailsDocs:(id)sender
{
    [self openURL:@"http://api.rubyonrails.org/"];
}

- (IBAction)openRailsOneClick:(id)sender
{
    [self openURL:@"http://railsoneclick.com/"];
}

@end
