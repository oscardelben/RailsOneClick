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
- (void)executeScript:(NSString *)name;
@end

@implementation InstallViewController

@synthesize installButton, progressIndicator;
@synthesize appController;

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:NSFileHandleDataAvailableNotification object:nil];
}

- (IBAction)installRuby:(id)sender
{
    // Don't block the main thread
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [installButton setEnabled:NO];
        [progressIndicator startAnimation:nil];
    }];
    
    
    [operation addExecutionBlock:^{
        [self executeScript:@"install_directory_structure"];
        [self executeScript:@"install_ruby"];
        [self executeScript:@"install_rails"];
    }];
    
    [operation setCompletionBlock:^{
        [progressIndicator stopAnimation:nil];
        [installButton setEnabled:YES];
        [appController rubyInstalled];
    }];
    
    [queue addOperation:operation];
    
}

- (void)executeScript:(NSString *)name
{
    NSLog(@"executing %@", name);
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
    
    // TODO: we may have to send the terminate message if the user exits
    [task launch];
    [file waitForDataInBackgroundAndNotify];
    [task waitUntilExit];

    // TODO: we should return a BOOL here to indicate success or failure
    int status = [task terminationStatus];
    
    if (status == TASK_SUCCESS_VALUE)
        NSLog(@"Task succeeded.");
    else
        NSLog(@"Task failed.");

}

// TODO: we can output this to a log viewer or something
- (void)dataReceived:(NSNotification *)notification
{
    NSFileHandle *fileHandle = [notification object];
    
    NSData *data;
    data = [fileHandle availableData];

    if ([data length]) {
        NSString *string = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        NSLog (@"%@", string);
    }
    [fileHandle waitForDataInBackgroundAndNotify];
}


@end
