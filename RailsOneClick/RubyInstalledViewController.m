//
//  RubyInstalledViewController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "RubyInstalledViewController.h"

@interface RubyInstalledViewController ()

@end

@implementation RubyInstalledViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)openTerminalWindow:(id)sender
{
    NSString *script = @"cd ~/Documents/rails_one_click; export PATH=~/Documents/rails_one_click/ruby/bin:$PATH; clear";
    NSString *apple_script = [NSString stringWithFormat:@"tell application \"Terminal\" to do script \"%@\"\ntell application \"Terminal\" to activate", script];
    
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource:apple_script];
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
    [self openURL:@"https://github.com/oscardelben/RailsOneClick"];
}

@end
