//
//  InfoPortal.m
//  InfoPortal
//
//  Created by USTB on 12-8-27.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "InfoPortal.h"

@implementation InfoPortal

- (BOOL)application {
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"infoportal.db"];
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:@"infoportal.db"];
    NSLog(@"Source Path: %@\n Documents Path: %@ \n Folder Path: %@", sourcePath, documentsDirectory, folderPath);
    NSError *error;
    
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:folderPath error:&error];
    return YES;
}

@end
