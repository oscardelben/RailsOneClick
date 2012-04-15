//
//  InstallViewController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "InstallViewController.h"

#define TASK_SUCCESS_VALUE 0

@interface InstallViewController ()
- (BOOL)executeScript:(NSString *)name;
@end

@implementation InstallViewController

@synthesize installButton, progressIndicator;
@synthesize appController;
@synthesize statusLabel;
@synthesize logWindowController;

- (void)awakeFromNib
{
    [statusLabel setHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:NSFileHandleDataAvailableNotification object:nil];

    self.logWindowController = [[LogWindowController alloc] initWithWindowNibName:@"LogWindowController"];
}

- (IBAction)installRuby:(id)sender
{
    // Don't block the main thread
    // TODO: if rails installation fails don't install Ruby again
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [installButton setEnabled:NO];
        [progressIndicator startAnimation:nil];
        [statusLabel setHidden:NO];
        [statusLabel setStringValue:@"Beginning installation"];
        // reset log data
        [logWindowController performSelectorOnMainThread:@selector(resetTextView) withObject:nil waitUntilDone:NO];
    }];
    
    
    [operation addExecutionBlock:^{
        [self executeScript:@"install_directory_structure"];
        [statusLabel setStringValue:@"Installing Ruby"];
        [self executeScript:@"install_ruby"];
        [statusLabel setStringValue:@"Beginning Rails"];
        [self executeScript:@"install_rails"];
    }];
    
    [operation setCompletionBlock:^{
        [progressIndicator stopAnimation:nil];
        [installButton setEnabled:YES];
        [appController rubyInstalled];
        [statusLabel setHidden:YES];
    }];
    
    [queue addOperation:operation];
    
}

- (BOOL)executeScript:(NSString *)name
{
    NSString *scriptPath = [[NSBundle mainBundle] pathForResource:name ofType:@"sh" inDirectory:@"scripts"];

    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath:scriptPath];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardError:pipe];
    [task setStandardInput:[NSPipe pipe]];
    
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    // TODO: we may have to send the terminate message if the user exits the app
    [task launch];
    [file waitForDataInBackgroundAndNotify];
    [task waitUntilExit];

    int status = [task terminationStatus];
    
    if (status == TASK_SUCCESS_VALUE)
        return YES;
    else
        return NO;

}

- (void)dataReceived:(NSNotification *)notification
{
    NSFileHandle *fileHandle = [notification object];
    
    NSData *data;
    data = [fileHandle availableData];

    if ([data length]) {
        NSString *newData = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        [logWindowController performSelectorOnMainThread:@selector(appendString:) withObject:newData waitUntilDone:NO];
        
    }
    [fileHandle waitForDataInBackgroundAndNotify];
}

- (IBAction)openLogWindow:(id)sender
{    
    if (! [logWindowController.window isVisible]) {
        [logWindowController.window makeKeyAndOrderFront:nil];
    }
}

@end
