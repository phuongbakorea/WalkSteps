//
//  HistoryInfo.h
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/10/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryInfo : NSObject {
    int _id;
    int _year;
    int _month;
    int _day;
    int _hour;
    int _steps;
    double _distance;
}


@property (nonatomic, assign) int uniqueId;
@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int steps;
@property (nonatomic, assign) double distance;

- (id)initData:(int) _id year: (int)year month:(int) month day:(int) day hour: (int) hour steps:(int) steps distance:(double) distance;

@end
