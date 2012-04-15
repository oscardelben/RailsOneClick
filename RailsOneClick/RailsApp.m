//
//  RailsApp.m
//  RailsOneClick
//
//  Created by Oscar Del Ben on 4/15/12.
//  Copyright (c) 2012 Fructivity. All rights reserved.
//

#import "RailsApp.h"

@implementation RailsApp

+ (NSMutableArray *)all
{
    RailsApp *anApp = [[RailsApp alloc] init];
    return [NSMutableArray arrayWithObjects:anApp, nil];
}

- (NSString *)name
{
    return @"my awesome app";
}


@end
