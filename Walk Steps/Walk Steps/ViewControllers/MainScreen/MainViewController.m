//
//  MainViewController.m
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/9/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import "MainViewController.h"
#import "WalkStepsContants.h"

CGFloat kMinimumSpeed        = 0.3f;
CGFloat kMaximumWalkingSpeed = 1.9f;
CGFloat kMaximumRunningSpeed = 7.5f;
CGFloat kMinimumRunningAcceleration = 3.5f;

@interface MainViewController ()

@property (strong, nonatomic) NSTimer *shakeDetectingTimer;


@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) CMMotionActivityManager *motionActivityManager;
@property (nonatomic, readonly) double currentSpeed;


typedef enum
{
    MotionTypeNotMoving = 1,
    MotionTypeWalking,
    MotionTypeRunning,
    MotionTypeAutomotive
} MotionType;

@property (nonatomic, readonly) MotionType motionType;
@property (nonatomic, readonly) CMAcceleration acceleration;
@property (nonatomic, readonly) BOOL isShaking;
@property (nonatomic) MotionType previousMotionType;
@property (nonatomic, readonly) double countStep;

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
    
    _countStep = 0;
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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleLocationChangedNotification:)
                                                 name:LOCATION_DID_CHANGED_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleLocationWasPausedNotification:)
                                                 name:LOCATION_WAS_PAUSED_NOTIFICATION
                                               object:nil];
    self.motionManager = [[CMMotionManager alloc] init];
    
    [self startDetection];
    
}

- (void)handleLocationWasPausedNotification:(NSNotification *)note
{
}

- (void)startDetection
{
    [[LocationManagement locationService] start];
    
    self.shakeDetectingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                                                target:self
                                                              selector:@selector(detectShaking)
                                                              userInfo:Nil
                                                               repeats:YES];
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
     {
         _acceleration = accelerometerData.acceleration;
         [self calculateMotionType];
         dispatch_async(dispatch_get_main_queue(), ^{
             

         });
     }];
    
    if ([self isSupportDevice] && [self motionHardwareAvailable]) {
        if (!self.motionActivityManager) {
            self.motionActivityManager = [[CMMotionActivityManager alloc] init];
        }
        
        [self.motionActivityManager startActivityUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMMotionActivity *activity) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (activity.walking) {
                    _motionType = MotionTypeWalking;
                } else if (activity.running) {
                    _motionType = MotionTypeRunning;
                } else if (activity.automotive) {
                    _motionType = MotionTypeAutomotive;
                } else if (activity.stationary || activity.unknown) {
                    _motionType = MotionTypeNotMoving;
                }
                
                // If type was changed, then call delegate method
                if (self.motionType != self.previousMotionType) {
                    self.previousMotionType = self.motionType;
                    
                    if (self.motionType == MotionTypeWalking) {
                        [self doWalkStep];
                    }
                }
            });
            
        }];
    }
}

- (void) doWalkStep {
    _countStep++;
    
    NSDate *now = [NSDate date];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour fromDate:now];

    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    NSInteger hour = [components hour];
    
    [_btnWalkStep setTitle:[NSString stringWithFormat:@"%0.0f", _countStep] forState:UIControlStateNormal];
}

- (void)detectShaking
{
    //Array for collecting acceleration for last one seconds period.
    static NSMutableArray *shakeDataForOneSec = nil;
    //Counter for calculating completion of one second interval
    static float currentFiringTimeInterval = 0.0f;
    
    currentFiringTimeInterval += 0.01f;
    if (currentFiringTimeInterval < 1.0f) {// if one second time intervall not completed yet
        if (!shakeDataForOneSec)
            shakeDataForOneSec = [NSMutableArray array];
        
        // Add current acceleration to array
        NSValue *boxedAcceleration = [NSValue value:&_acceleration withObjCType:@encode(CMAcceleration)];
        [shakeDataForOneSec addObject:boxedAcceleration];
    } else {
        // Now, when one second was elapsed, calculate shake count in this interval. If there will be at least one shake then
        // we'll determine it as shaked in all this one second interval.
        
        int shakeCount = 0;
        for (NSValue *boxedAcceleration in shakeDataForOneSec) {
            CMAcceleration acceleration;
            [boxedAcceleration getValue:&acceleration];
            
            /*********************************
             *       Detecting shaking
             *********************************/
            double accX_2 = powf(acceleration.x,2);
            double accY_2 = powf(acceleration.y,2);
            double accZ_2 = powf(acceleration.z,2);
            
            double vectorSum = sqrt(accX_2 + accY_2 + accZ_2);
            
            if (vectorSum >= kMinimumRunningAcceleration) {
                shakeCount++;
            }
            /*********************************/
        }
        _isShaking = shakeCount > 0;
        
        shakeDataForOneSec = nil;
        currentFiringTimeInterval = 0.0f;
    }
}

- (void)handleLocationChangedNotification:(NSNotification *)note
{
    self.currentLocation = [LocationManagement locationService].lastLocation;
    _currentSpeed = self.currentLocation.speed;
    if (_currentSpeed < 0) {
        _currentSpeed = 0;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{

        
    });
    
    [self calculateMotionType];
}

- (BOOL) isSupportDevice {
    
    BOOL isSupported = NO;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        isSupported = YES;
    }
    
    return isSupported;
}
- (BOOL)motionHardwareAvailable
{
    static BOOL isAvailable = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isAvailable = [CMMotionActivityManager isActivityAvailable];
    });
    
    return isAvailable;
}

- (void)calculateMotionType
{
    if ([self isSupportDevice] && [self motionHardwareAvailable]) {
        return;
    }
    
    if (_currentSpeed < kMinimumSpeed) {
        _motionType = MotionTypeNotMoving;
    } else if (_currentSpeed <= kMaximumWalkingSpeed) {
        _motionType = _isShaking ? MotionTypeRunning : MotionTypeWalking;
    } else if (_currentSpeed <= kMaximumRunningSpeed) {
        _motionType = _isShaking ? MotionTypeRunning : MotionTypeAutomotive;
    } else {
        _motionType = MotionTypeAutomotive;
    }
    
    // If type was changed, then call delegate method
    if (self.motionType != self.previousMotionType) {
        self.previousMotionType = self.motionType;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //update motion
        });
    }
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
