//
//  WalkStepsContants.h
//  Walk Steps
//
//  Created by Truong Ba Phuong on 5/10/16.
//  Copyright © 2016 NRC. All rights reserved.
//

#ifndef WalkStepsContants_h
#define WalkStepsContants_h

#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_6plus ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

#define IS_IPHONE_3 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#define Key_WalkStep  @"walkstep"
#define DefaultWalkStep  70 //70 cm

#endif /* WalkStepsContants_h */
