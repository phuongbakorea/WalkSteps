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
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Dashboard";
        self.tabBarItem.title = @"Dashboard";
        self.tabBarItem.image = [UIImage imageNamed:@"dashboard"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _btnWalkStep.layer.cornerRadius = _btnWalkStep.bounds.size.width / 2.0;
    
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
