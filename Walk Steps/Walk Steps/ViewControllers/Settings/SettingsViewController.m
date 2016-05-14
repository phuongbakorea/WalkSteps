//
//  SettingsViewController.m
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/9/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import "SettingsViewController.h"
#import "WalkStepsContants.h"

@interface SettingsViewController ()

@property long _walkStep;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
        self.tabBarItem.title = @"Settings";
        self.tabBarItem.image = [UIImage imageNamed:@"settings"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:Key_WalkStep]) {
        self._walkStep = [[defaults objectForKey:Key_WalkStep] integerValue];
    } else {
        self._walkStep = DefaultWalkStep;
    }
    
    _txtWalkStep.text = [NSString stringWithFormat:@"%ld", self._walkStep];
}


-(void) onPlus {
    self._walkStep++;
    
    [self saveWalkStep];
}

-(void) onMinus {
    self._walkStep--;
    if (self._walkStep <= 10) {
        self._walkStep = 10;
    }
    
    [self saveWalkStep];
    
}

- (void) saveWalkStep {
    _txtWalkStep.text = [NSString stringWithFormat:@"%ld", self._walkStep];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%ld", self._walkStep] forKey: Key_WalkStep];
    [defaults synchronize];
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
