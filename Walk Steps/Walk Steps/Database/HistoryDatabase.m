//
//  HistoryDatabase.m
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/10/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import "HistoryDatabase.h"

@implementation HistoryDatabase


static HistoryDatabase *_database;

+ (HistoryDatabase*)database {
    if (_database == nil) {
        _database = [[HistoryDatabase alloc] init];
    }
    return _database;
}

- (id)init {
    if ((self = [super init])) {

            // Set the documents directory path to the documentsDirectory property.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
            
            // Keep the database filename.
        NSString *dbFilename = @"history.sqlite3";
            
            // Copy the database file into the documents directory if necessary.
        [self copyDatabaseIntoDocumentsDirectory: dbFilename];

        
        // Set the database file path.
        NSString *sqLiteDb = [self.documentsDirectory stringByAppendingPathComponent:dbFilename];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

-(void)copyDatabaseIntoDocumentsDirectory: (NSString *) dbFilename{
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:dbFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: dbFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            //            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

- (void)dealloc {
    sqlite3_close(_database);
}

- (NSMutableArray *)getAllHistoryInfos {
    
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT id, year, month, day, sum(steps), sum(distance) FROM history group by year, month, day ORDER BY year, month, day ASC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            int year = sqlite3_column_int(statement, 1);
            int month = sqlite3_column_int(statement, 2);
            int day = sqlite3_column_int(statement, 3);
            int steps = sqlite3_column_int(statement, 4);
            double distance = sqlite3_column_double(statement, 5);
            
            HistoryInfo *info = [[HistoryInfo alloc] initData:uniqueId year : year month:month day: day hour:0 steps: steps distance:distance];
            [retval addObject:info];
        }
        sqlite3_finalize(statement);
    }
    return retval;
    
}

- (NSArray *) getAllHistoryInfosByDay: (int) year month: (int) month day : (int) day {
    
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT id, year, month, day, sum(steps), sum(distance), hour FROM history group by year, month, day, hour ORDER BY year, month, day, hour ASC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            int year = sqlite3_column_int(statement, 1);
            int month = sqlite3_column_int(statement, 2);
            int day = sqlite3_column_int(statement, 3);
            int steps = sqlite3_column_int(statement, 4);
            double distance = sqlite3_column_double(statement, 5);
            int hour = sqlite3_column_int(statement, 6);
            
            HistoryInfo *info = [[HistoryInfo alloc] initData:uniqueId year : year month:month day: day hour:hour steps: steps distance:distance];
            [retval addObject:info];
        }
        sqlite3_finalize(statement);
    }
    return retval;
    
}

- (HistoryInfo *)getHistoryInfoDetail:(int)uniqueId {
    HistoryInfo *retval = nil;
    NSString *query = [NSString stringWithFormat:@"SELECT id, year, month, day, hour, steps, distance  FROM history WHERE id=%d", uniqueId];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            int year = sqlite3_column_int(statement, 1);
            int month = sqlite3_column_int(statement, 2);
            int day = sqlite3_column_int(statement, 3);
            int hour = sqlite3_column_int(statement, 4);
            int steps = sqlite3_column_int(statement, 5);
            double distance = sqlite3_column_double(statement, 6);
            
            retval = [[HistoryInfo alloc] initData:uniqueId year : year month:month day: day hour:hour steps: steps distance:distance];
            break;
        }
        sqlite3_finalize(statement);
    }
    return retval;
}

- (void)insertData:(long)year month:(long) month day:(long) day hour: (long) hour steps:(long) steps distance:(double) distance {
    
    NSString *query = [NSString stringWithFormat:@"insert into history(year, month, day, hour, steps, distance) values(%ld, %ld, %ld, %ld, %ld, %0.0f)", year, month, day, hour, steps, distance];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        int executeQueryResults = sqlite3_step(statement);
        if (executeQueryResults == SQLITE_DONE) {
            
        }
        else {
            // If could not execute the query show the error message on the debugger.
            NSLog(@"DB Error: %s", sqlite3_errmsg(_database));
        }
        sqlite3_finalize(statement);
    }
    
}
@end
