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
@synthesize finderButton;
@synthesize terminalButton;

- (void)changeButtonColor:(NSButton *)button color:(NSColor *)color
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSCenterTextAlignment];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                     color, NSForegroundColorAttributeName,
                                     style, NSParagraphStyleAttributeName,
                                     [NSFont fontWithName:@"Lucida Grande" size:12], NSFontAttributeName,
                                     [[NSShadow alloc] init], NSShadowAttributeName,
                                     nil];
    NSAttributedString *attrString = [[NSAttributedString alloc]
                                      initWithString:[button title] attributes:attrsDictionary];
    [button setAttributedTitle:attrString];
}

- (void)awakeFromNib
{
    [self changeButtonColor:finderButton color:[NSColor whiteColor]];
    [self changeButtonColor:terminalButton color:[NSColor whiteColor]];
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
