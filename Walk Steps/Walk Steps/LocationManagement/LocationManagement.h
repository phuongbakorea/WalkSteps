//
//  LocationManagement.h
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/14/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationManagement : NSObject<CLLocationManagerDelegate> {
    
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocationManager *significantLocationManager;

@property (strong, nonatomic) CLLocation* lastLocation;
@property (nonatomic) CLLocationCoordinate2D lastCoordinate;

@property (nonatomic) BOOL allowsBackgroundLocationUpdates;

+ (LocationManagement*)locationService;
- (void)start;

@end
