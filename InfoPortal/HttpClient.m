//
//  HttpClient.m
//  InfoPortal
//
//  Created by USTB on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient

-(NSString *)request:(NSString *)urlString: (NSDictionary *)keyValues: (NSString *)methord {
    NSString *myRequestString = @"";
    for(id key in keyValues) {
        [myRequestString stringByAppendingFormat:@"&%@=%@", key, [keyValues valueForKey:key]];
    }
    NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requests = [[NSMutableURLRequest alloc] initWithURL:url];
    [requests setHTTPMethod:methord];
    [requests setHTTPBody:myRequestData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:requests returningResponse:nil error:nil];
    NSLog(@"body: %@", [NSString stringWithUTF8String:[returnData init]]);
    return body;
}

-(NSString *)get:(NSString *)urlString :(NSDictionary *)keyValues {
    return [self request:urlString :keyValues :@"get"];
}

-(NSString *)post:(NSString *)urlString :(NSDictionary *)keyValues {
    return [self request:urlString :keyValues :@"post"];
}

@end
