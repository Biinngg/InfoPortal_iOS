//
//  ClassDatabase.m
//  InfoPortal
//
//  Created by USTB on 12-8-28.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "ClassDatabase.h"

@implementation ClassDatabase {
    int classNumber;
    long termStartStamp;
}

-(id) init {
    self = [super init];
    if(self) {
        classNumber = 0;
        termStartStamp = 0;
    }
    return self;
}

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
    [database close];
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
    [database close];
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
    classNumber = [result count];
    [database close];
    return result;
}

-(long)getTermTime: (NSString *) column {
    long result;
    IPDate *date = [IPDate new];
    NSString *condition = @"_id=1";
    NSArray *array = [NSArray arrayWithObject:column];
    IPDatabase *database = [IPDatabase new];
    [database open];
    int status = [database query:@"cla_time" :array :condition :nil :nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        NSLog(@"getTermStart %@", [next objectAtIndex:0]);
        result = [date timeToStamp:[next objectAtIndex:0] :@"YYYYMMdd"];
    }
    [database close];
    return result;
}

-(long)getTermStart {
    termStartStamp = [self getTermTime:@"begin"];
    return termStartStamp;
}

-(long)getTermEnd {
    return [self getTermTime:@"end"];
}

-(int) getWeekNum:(long)curTimeStamp {
    if(termStartStamp == 0)
        [self getTermStart];
    long weekNum = (curTimeStamp - termStartStamp) / 604800;
    return weekNum;
}

-(NSArray *)getUsage:(int) buildId: (int) roomNum: (long)startTimeStamp :(int)days {
    NSMutableArray *result;
    result = [[NSMutableArray alloc] init];
    NSString *condition = [NSString stringWithFormat:@"build=%d and room=%d", buildId, roomNum];
    if(classNumber == 0)
        [self getTimes];
    NSMutableArray *columns;
    columns = [[NSMutableArray alloc] init];
    for(int i=0; i<classNumber; i++) {
        NSString *str = [NSString stringWithFormat:@"class%d", (i+1)];
        [columns addObject:str];
    }
    IPDatabase *database = [IPDatabase new];
    IPDate *date = [IPDate new];
    for(int i=0;i<days;i++) {
        StructUsage *usage = [StructUsage new];
        long stamp = startTimeStamp + i * 86400;
        NSString *weekName = [date getWeekName:stamp];
        int weekNum = [self getWeekNum:stamp];
        [database query:weekName :columns :condition :nil :nil];
        NSArray *next = [database moveToNext];
        NSMutableArray *status;
        status = [[NSMutableArray alloc] init];
        for(int j=0; j<classNumber; j++) {
            int value = [[next objectAtIndex:j] integerValue] & (1 << weekNum);
            if(value != 0)
                value = 1;
            [status addObject:[NSString stringWithFormat:@"%d", value]];
        }
        usage->timeStamp = stamp;
        usage->usageStatus = status;
        [result addObject:usage];
    }
    return result;
}

@end
