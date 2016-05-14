//
//  HistoryTableViewController.h
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/9/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewController : UITableViewController {
    NSArray *_historyInfoArray;
}

@property (nonatomic, retain) NSArray *historyInfoArray;

@end
