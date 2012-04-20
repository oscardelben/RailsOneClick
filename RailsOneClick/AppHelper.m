//
//  AppHelper.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/20/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper

+ (void)changeButtonColor:(NSButton *)button color:(NSColor *)color alternate:(BOOL)alternate
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSCenterTextAlignment];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                     color, NSForegroundColorAttributeName,
                                     style, NSParagraphStyleAttributeName,
                                     [NSFont fontWithName:@"Lucida Grande" size:13], NSFontAttributeName,
                                     [[NSShadow alloc] init], NSShadowAttributeName,
                                     nil];
    NSAttributedString *attrString = [[NSAttributedString alloc]
                                      initWithString:[button title] attributes:attrsDictionary];
    
    if (alternate) {
        [button setAttributedAlternateTitle:attrString];
    } else {
        [button setAttributedTitle:attrString];
    }
}


@end
