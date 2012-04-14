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
    NSString *apple_script = [NSString stringWithFormat:@"tell application \"Terminal\" to do script \"%@\"", script];
    
    NSAppleScript *as = [[NSAppleScript alloc] initWithSource:apple_script];
    [as executeAndReturnError:nil];
}

@end
