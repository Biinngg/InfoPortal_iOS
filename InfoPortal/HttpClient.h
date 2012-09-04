//
//  HttpClient.h
//  InfoPortal
//
//  Created by USTB on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject

-(NSString *) get: (NSString *)urlString: (NSDictionary *)keyValues;
-(NSString *) post: (NSString *)urlString: (NSDictionary *)keyValues;

@end
