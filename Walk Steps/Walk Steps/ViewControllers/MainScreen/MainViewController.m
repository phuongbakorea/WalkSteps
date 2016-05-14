//
//  MainViewController.m
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/9/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import "MainViewController.h"
#import "WalkStepsContants.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString * xib = @"MainViewController";
    
    if (IS_IPHONE_3) {
        xib = [NSString stringWithFormat:@"%@_%@",nibNameOrNil, @"ip4"];
    } else if (IS_IPHONE_4) {
        xib = [NSString stringWithFormat:@"%@_%@",nibNameOrNil, @"ip4"];
    } else if (IS_IPHONE_5) {
        xib = [NSString stringWithFormat:@"%@_%@",nibNameOrNil, @"ip5"];
    } else if (IS_IPHONE_6) {
        xib = [NSString stringWithFormat:@"%@_%@",nibNameOrNil, @"ip6"];
    } else if (IS_IPHONE_6plus) {
        xib = [NSString stringWithFormat:@"%@_%@",nibNameOrNil, @"ip6plus"];
    } else {
        xib = [NSString stringWithFormat:@"%@_%@",nibNameOrNil, @"ip6plus"];
    }
    self = [super initWithNibName:xib bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Dashboard";
        self.tabBarItem.title = @"Dashboard";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [[self navigationController] setNavigationBarHidden:NO animated:YES];


    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    
    NSString *compileDate = [NSString stringWithUTF8String:__DATE__];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM d yyyy"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:usLocale];
    NSDate *aDate = [df dateFromString:compileDate];
    NSString *stringFromDate = [df stringFromDate:aDate];
    _txtBuildVersionLabel.text = [NSString stringWithFormat:@"VERSION: %@ BUILD NUMBER: %@ BUILD DATE: %@", version, build, stringFromDate];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
