//
//  InstallViewController.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/14/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "InstallViewController.h"
#import "AppHelper.h"

#define TASK_SUCCESS_VALUE 0
#define SUCCESS_ALERT_TAG 1

@interface InstallViewController ()
- (BOOL)executeScript:(NSString *)name;
- (void)showErrorMessage;
- (void)setupInstallationUI;
- (void)teardownInstallationUI;
@end

@implementation InstallViewController

@synthesize installButton;
@synthesize logButton;
@synthesize appController;
@synthesize statusLabel;
@synthesize logWindowController;
@synthesize checkPrerequisitesButton;

- (void)awakeFromNib
{
    [statusLabel setHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:NSFileHandleDataAvailableNotification object:nil];

    self.logWindowController = [[LogWindowController alloc] initWithWindowNibName:@"LogWindowController"];
    
    [AppHelper changeButtonColor:checkPrerequisitesButton color:[NSColor whiteColor] alternate:NO];
    [AppHelper changeButtonColor:checkPrerequisitesButton color:[NSColor blackColor] alternate:YES];
    [AppHelper changeButtonColor:installButton color:[NSColor whiteColor] alternate:NO];
    [AppHelper changeButtonColor:installButton color:[NSColor blackColor] alternate:YES];
}

- (void)showPrerequisitesInstallationDialog
{
    NSAlert *alert = [NSAlert alertWithMessageText:PREREQUISITES_INSTALLATION_MESSAGE defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert runModal];
}

- (BOOL)prerequisitesInstalled
{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/type"];
    [task setArguments:[NSArray arrayWithObject:@"git-diff-grep"]];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardError:pipe];
    [task setStandardInput:[NSPipe pipe]];
    
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
    
    [task waitUntilExit];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return [result rangeOfString:@"not found"].location == NSNotFound;
}

- (IBAction)checkPrerequisites:(id)sender
{
    if ([self prerequisitesInstalled]) {
        NSAlert *alert = [NSAlert alertWithMessageText:PREREQUISITES_INSTALLED defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
        [alert runModal];
    } else {
        [self showPrerequisitesInstallationDialog];
    }
}

- (IBAction)installRuby:(id)sender
{
    if (installing) {
        return;
    }
    
    if (! [self prerequisitesInstalled]) {
        [self showPrerequisitesInstallationDialog];
        return;
    }
    
    // Don't block the main thread
    
    [self setupInstallationUI];
    [logWindowController resetTextView];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        BOOL success;
                
        success = [self executeScript:@"install_directory_structure"];
        
        if (!success) {
            [self performSelectorOnMainThread:@selector(showErrorMessage) withObject:nil waitUntilDone:NO];
            return;
        }
        
        [self executeScript:@"install_ruby"];
        
        if (!success) {
            [self performSelectorOnMainThread:@selector(showErrorMessage) withObject:nil waitUntilDone:NO];
            return;
        }
        
        [self executeScript:@"install_rails"];
        
        if (!success) {
            [self performSelectorOnMainThread:@selector(showErrorMessage) withObject:nil waitUntilDone:NO];
            return;
        }

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
        
        if ([newData rangeOfString:@"ROC_STATUS"].location == NSNotFound) {
            [logWindowController performSelectorOnMainThread:@selector(appendString:) withObject:newData waitUntilDone:NO];
        } else {
            NSString *status = [NSString stringWithFormat:@"Status: %@", [newData substringFromIndex:12]];
            [statusLabel setStringValue:status];
        }
        
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
    
    [logButton setImage:[NSImage imageNamed:@"log_yellow.png"]];
    [logButton setAlternateImage:[NSImage imageNamed:@"log_yellow.png"]];
    
    NSAlert *alert = [NSAlert alertWithMessageText:INSTALLATION_ERROR_MESSAGE defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert runModal];
    [self teardownInstallationUI];
}

- (void)setupInstallationUI
{
    installing = YES;
    
    [AppHelper changeButtonColor:installButton color:[NSColor blackColor] alternate:NO];
    [installButton setImage:[NSImage imageNamed:@"button_yellow.png"]];
    [installButton setTitle:@"Installing Ruby..."];
    [installButton setAlternateTitle:@"Installing Ruby..."];
    
    [statusLabel setHidden:NO];
    [statusLabel setStringValue:@"Beginning installation"];
    [logButton setImage:[NSImage imageNamed:@"log.png"]];
    [logButton setAlternateImage:[NSImage imageNamed:@"log.png"]];
}

- (void)teardownInstallationUI
{
    [installButton setImage:[NSImage imageNamed:@"button_gray.png"]];
    [installButton setTitle:@"Begin installation"];
    [installButton setAlternateTitle:@"Begin installation"];
    [AppHelper changeButtonColor:installButton color:[NSColor whiteColor] alternate:NO];
    
    [statusLabel setHidden:YES];
    
    installing = NO;
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
