//
//  IPDatabase.h
//  InfoPortal
//
//  Created by USTB on 12-8-27.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface IPDatabase : NSObject {
    NSString *path;
}

-(void) open;
-(NSArray *) query: (NSString *) table selection:(NSArray *) columns: (NSString *) orderBy:(NSString *) limit;
-(int) insert: (NSString *) table selection: (NSDictionary *) values;
-(int) remove: (NSString *) table: (NSString *)selection;
-(int) update: (NSString *) table selection: (NSDictionary *) values;

@end
