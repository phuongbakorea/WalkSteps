//
//  HistoryTableViewController.h
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/9/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourHistoryTableViewController : UITableViewController {
    NSArray *_historyInfoArray;
    
    int _yearGlobal;
    int _monthGlobal;
    int _dayGlobal;
    
}

@property (nonatomic, retain) NSArray *historyInfoArray;

@property int yearGlobal;
@property int monthGlobal;
@property int dayGlobal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil year: (int) year month : (int) month day : (int) day;
@end
