//
//  ClassDatabase.h
//  InfoPortal
//
//  Created by USTB on 12-8-28.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPDatabase.h"
/**
 * 用于为ClassView提供数据库访问方法。
 **/
@interface ClassDatabase : NSObject

/**
 * 获得教学楼名，返回NSString数组.
 **/
-(NSArray *) getBuild;
/**
 * 获得楼层数量
 **/
-(int) getFloor: (NSString *) buildName;
/**
 * 获得节次
 **/
-(NSArray *) getTimes;
/**
 * 获得连续几天的教室使用状况
 **/
-(NSArray *) getUsage: (long) startTimeStamp : (int) days;
/**
 * 获得教室搜索结果
 **/
-(NSArray *) getResult: (long) buildSelect: (int) floorFrom floorTo: (int) timesFrom timesTo: (long) timeStamp;

@end
