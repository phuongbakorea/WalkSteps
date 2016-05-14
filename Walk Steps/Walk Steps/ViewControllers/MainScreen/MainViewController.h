//
//  MainViewController.h
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/9/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LocationManagement.h"
#import <CoreMotion/CoreMotion.h>

@interface MainViewController : UIViewController {
    IBOutlet UIButton  *_btnWalkStep;
    IBOutlet UILabel   *_txtBuildVersionLabel;
}

- (void)startDetectionWithUpdateBlock: (CMAccelerometerData *) accelerometerData;

@end
