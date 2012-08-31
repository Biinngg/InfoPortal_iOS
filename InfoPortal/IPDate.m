//
//  IPDate.m
//  InfoPortal
//
//  Created by Liu Bing on 12-8-31.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "IPDate.h"

@implementation IPDate

-(long)timeToStamp:(NSString *)date :(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate* dater = [formatter dateFromString:date];
    return [dater timeIntervalSince1970];
}

@end
