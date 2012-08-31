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
    result = [[NSMutableArray alloc] init];
    NSArray *array = [NSArray arrayWithObjects:@"_id", @"name", nil];
    IPDatabase *database = [IPDatabase new];
    [database open];
    int status = [database query:@"cla_build" :array :nil :@"floor_num DESC" :nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        while([next count] != 0) {
            StructBuild *build = [StructBuild new];
            build->buildId = [[next objectAtIndex:0] integerValue];
            build->buildName = [next objectAtIndex:1];
            [result addObject:build];
            next = [database moveToNext];
        }
    }
    return result;
}

-(int) getFloor:(int)buildId {
    int floorNum;
    NSString *condition = @"_id = ";
    condition = [condition stringByAppendingFormat:@"%d",buildId];
    NSLog(@"condition: %@", condition);
    NSArray *array = [NSArray arrayWithObject:@"floor_num"];
    IPDatabase *database = [IPDatabase alloc];
    [database open];
    int status = [database query:@"cla_build":array:condition:nil:nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        floorNum = [[next objectAtIndex:0] integerValue];
    }
    return floorNum;
}

-(NSArray *)getTimes {
    NSMutableArray *result;
    result = [[NSMutableArray alloc] init];
    NSString *condition = @"period=1";
    NSArray *array = [NSArray arrayWithObject:@"name"];
    IPDatabase *database = [IPDatabase new];
    [database open];
    int status = [database query:@"cla_time":array:condition:nil:nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        while([next count] != 0) {
            [result addObject:[next objectAtIndex:0]];
            next = [database moveToNext];
        }
    }
    return result;
}

-(long)getTermStart {
    long result;
    IPDate *date = [IPDate new];
    NSString *condition = @"_id=1";
    NSArray *array = [NSArray arrayWithObject:@"begin"];
    IPDatabase *database = [IPDatabase new];
    [database open];
    int status = [database query:@"cla_time" :array :condition :nil :nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        result = [date timeToStamp:[next objectAtIndex:0] :@"YYMMdd"];
    }
    return result;
}

-(NSArray *)getUsage:(long)startTimeStamp :(int)days {
    NSMutableArray *result;
    result = [[NSMutableArray alloc] init];
}

@end
