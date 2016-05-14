//
//  HistoryInfo.m
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/10/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import "HistoryInfo.h"

@implementation HistoryInfo

- (id)initData:(int) _id year: (int)year month:(int) month day:(int) day hour: (int) hour steps:(int) steps distance:(double) distance
{
    if ((self = [super init])) {
        self.year = year;
        self.month = month;
        self.day = day;
        self.steps = steps;
        self.hour = hour;
        self.distance = distance;
    }
    return self;
}

@end
