//
//  InstallViewController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "InstallViewController.h"

#define TASK_SUCCESS_VALUE 0
#define SUCCESS_ALERT_TAG 1

@interface InstallViewController ()
- (BOOL)executeScript:(NSString *)name;
- (void)showErrorMessage;
- (void)setupInstallationUI;
- (void)teardownInstallationUI;
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
        [self setupInstallationUI];
        // reset log data
        [logWindowController performSelectorOnMainThread:@selector(resetTextView) withObject:nil waitUntilDone:NO];
    }];
    
    
    [operation addExecutionBlock:^{
        BOOL success;
                
        success = [self executeScript:@"install_directory_structure"];
        
        if (!success) {
            [self performSelectorOnMainThread:@selector(showErrorMessage) withObject:nil waitUntilDone:NO];
            return;
        }
        
        [statusLabel setStringValue:@"Installing Ruby"];
        [self executeScript:@"install_ruby"];
        
        if (!success) {
            [self performSelectorOnMainThread:@selector(showErrorMessage) withObject:nil waitUntilDone:NO];
            return;
        }
        
        [statusLabel setStringValue:@"Installing Rails"];
        [self executeScript:@"install_rails"];
        
        if (!success) {
            [self performSelectorOnMainThread:@selector(showErrorMessage) withObject:nil waitUntilDone:NO];
            return;
        }

        [self teardownInstallationUI];
        [self performSelectorOnMainThread:@selector(showSuccessMessage) withObject:nil waitUntilDone:NO];
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

- (void)showErrorMessage
{
    [self teardownInstallationUI];
    
    NSAlert *alert = [NSAlert alertWithMessageText:INSTALLATION_ERROR_MESSAGE defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert runModal];
}

- (void)setupInstallationUI
{
    [installButton setEnabled:NO];
    [progressIndicator startAnimation:nil];
    [statusLabel setHidden:NO];
    [statusLabel setStringValue:@"Beginning installation"];
}

- (void)teardownInstallationUI
{
    [progressIndicator stopAnimation:nil];
    [installButton setEnabled:YES];
    [statusLabel setHidden:YES];
}

- (void)showSuccessMessage
{
    NSAlert *alert = [NSAlert alertWithMessageText:INSTALLATION_SUCCESS_MESSAGE defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert beginSheetModalForWindow:self.view.window modalDelegate:self didEndSelector:@selector(installationCompleted) contextInfo:nil];
}

- (void)installationCompleted
{
    [appController rubyInstalled];
}


@end
