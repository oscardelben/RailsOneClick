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

- (BOOL)isFileExists:(NSString *)path
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:path];
    return [[NSFileManager defaultManager] fileExistsAtPath:foofile];
}

- (BOOL)isRubyInstalled
{
    return [self isFileExists:@"rails_one_click/ruby/bin/ruby"];
}

- (BOOL)isRailsInstalled
{
    return [self isFileExists:@"rails_one_click/ruby/bin/rails"];
}

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
