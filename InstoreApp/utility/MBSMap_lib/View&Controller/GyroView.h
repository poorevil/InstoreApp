//
//  GyroView.h
//  MBSMapViewController
//
//  Created by sunyifei on 2/27/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GyroView : UIImageView <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

+ (BOOL)gyroViewSupported;
- (void)startRotate;

@end
