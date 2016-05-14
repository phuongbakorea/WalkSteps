//
//  HistoryDatabase.h
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/10/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "HistoryInfo.h"

@interface HistoryDatabase : NSObject {
        sqlite3 *_database;
}

+ (HistoryDatabase*)database;
- (NSArray *) getAllHistoryInfos;
- (NSArray *) getAllHistoryInfosByDay: (int) year month: (int) month day : (int) day;
- (HistoryInfo *) getHistoryInfoDetail:(int)_id;

- (void)insertData:(int)year month:(int) month day:(int) day hour: (int) hour steps:(int) steps distance:(double) distance;

@end
