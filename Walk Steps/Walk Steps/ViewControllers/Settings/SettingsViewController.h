//
//  SettingsViewController.h
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/9/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController {
    IBOutlet UILabel *_txtWalkStep;
}


-(IBAction) onPlus;
-(IBAction) onMinus;
@end
