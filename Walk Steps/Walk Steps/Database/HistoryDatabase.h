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

@property (nonatomic, strong) NSString *documentsDirectory;

+ (HistoryDatabase*)database;
- (NSMutableArray *) getAllHistoryInfos;
- (NSMutableArray *) getAllHistoryInfosByDay: (int) year month: (int) month day : (int) day;
- (HistoryInfo *) getHistoryInfoDetail:(int)_id;

- (void)insertData:(long)year month:(long) month day:(long) day hour: (long) hour steps:(long) steps distance:(double) distance;

@end
