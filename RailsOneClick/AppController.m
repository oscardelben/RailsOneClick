//
//  AppController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "AppController.h"
#import "InstallViewController.h"
#import "RubyInstalledViewController.h"

@implementation AppController

@synthesize view;
@synthesize currentViewController;

- (BOOL)isRailsInstalled
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:@"rails_one_click/ruby/bin/rails"];
    return [[NSFileManager defaultManager] fileExistsAtPath:foofile];
}

// TODO: remove duplication

- (void)awakeFromNib
{
    if ([self isRailsInstalled]) {
        self.currentViewController = [[RubyInstalledViewController alloc] initWithNibName:@"RubyInstalledViewController" bundle:nil];
        [self.view addSubview:currentViewController.view];
    }
    else {
        self.currentViewController = [[InstallViewController alloc] initWithNibName:@"InstallViewController" bundle:nil];
        [currentViewController setValue:self forKey:@"appController"];
        [self.view addSubview:currentViewController.view];
    }
}

- (void)rubyInstalled
{
    for (NSView *aView in [self.view subviews])
        [aView removeFromSuperview];
    
    self.currentViewController = [[RubyInstalledViewController alloc] initWithNibName:@"RubyInstalledViewController" bundle:nil];
    [self.view addSubview:currentViewController.view];
}

@end
