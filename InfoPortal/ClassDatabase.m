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
    NSMutableArray *result;
    NSArray *array = [NSArray arrayWithObject:@"name"];
    IPDatabase *database = [IPDatabase alloc];
    [database open];
    int status = [database query:@"cla_build" :array :nil :@"floor_num DESC" :nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        while(next != nil) {
            [result addObject:[next objectAtIndex:0]];
            next = [database moveToNext];
        }
    }
    return result;
}

-(int) getFloor:(NSString *)buildName {
    int floorNum;
    NSString *condition = @"name = ";
    [condition stringByAppendingString:buildName];
    NSArray *array = [NSArray arrayWithObject:@"floor_num"];
    IPDatabase *database = [IPDatabase alloc];
    [database open];
    int status = [database query:@"cla_build":array:condition:nil:nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        floorNum = [next objectAtIndex:0];
    }
}

@end
