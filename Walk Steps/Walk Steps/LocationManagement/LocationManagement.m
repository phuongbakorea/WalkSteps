//
//  LocationManagement.m
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/14/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import "LocationManagement.h"
#import "WalkStepsContants.h"

@implementation LocationManagement

static LocationManagement *_locationService;

+ (LocationManagement*) locationService {
    if (_locationService == nil) {
        _locationService = [[LocationManagement alloc] init];
    }
    return _locationService;
}

- (id)init {
    if ((self = [super init])) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.delegate = self;
            
        self.significantLocationManager = [[CLLocationManager alloc] init];
        self.significantLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.significantLocationManager.distanceFilter = kCLDistanceFilterNone;
        self.significantLocationManager.delegate = self;
        
        
    }
    return self;
}

- (void)start
{

    if ([self.locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)]) {
            [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocatiomManager Delegaet
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (manager == self.locationManager) {
        CLLocation *location = [locations lastObject];
        self.lastLocation = location;
        self.lastCoordinate = location.coordinate;
        [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_DID_CHANGED_NOTIFICATION
                                                            object:location
                                                          userInfo:@{@"location":location}];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_DID_FAILED_NOTIFICATION
                                                        object:error
                                                      userInfo:@{@"error":error}];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined && [self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_AUTHORIZATION_STATUS_CHANGED_NOTIFICATION
                                                        object:self
                                                      userInfo:@{@"status":@(status)}];
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_WAS_PAUSED_NOTIFICATION
                                                        object:self];
}

@end
