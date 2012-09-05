//
//  HttpClient.h
//  InfoPortal
//
//  Created by USTB on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSOperation {
    NSURLRequest* _request;
    NSURLConnection* _connection;
    NSMutableData* _data;
    NSStringEncoding enc;
}

-(id)initWithURLString: (NSString *)url;

-(NSString *) get: (NSString *)urlString: (NSDictionary *)keyValues;
-(NSString *) post: (NSString *)urlString: (NSDictionary *)keyValues;

@property(readonly) NSData *data;
@end
