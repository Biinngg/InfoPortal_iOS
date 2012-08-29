//
//  ClassDatabase.m
//  InfoPortal
//
//  Created by USTB on 12-8-28.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "ClassDatabase.h"

@implementation ClassDatabase

-(NSArray *) getBuild {
    NSArray *array = [NSArray arrayWithObjects:@"name", nil];
    IPDatabase *database = [IPDatabase alloc];
    [database open];
    [database query:@"cla_build" :array :nil :@"floor_num DESC" :nil];}

@end
