//
//  MBSErrorCorrection.h
//  MBSMapViewController
//
//  Created by dujianping on 2/20/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobiConnection.h"

enum ERROR_CORRECTION_TYPE {
    ERROR_STORE_NEW = 1,
    ERROR_STORE_NAME = 2,
    ERROR_STORE_PHONE = 3,
    ERROR_STORE_CLOSE = 4,
    ERROR_STORE_LOGO = 5,
    ERROR_MALL_PHONE = 10,
    ERROR_MALL_OPENTIME = 11,
    ERROR_MALL_ADDRESS = 12,
};

@interface MBSErrorCorrection : NSObject<UIAlertViewDelegate>{
    enum ERROR_CORRECTION_TYPE alertType;
    NSInteger objectId;
}

-(void)showErrorCorrectionAlertWithTextField:(enum ERROR_CORRECTION_TYPE)type 
                                withObjectId:(long long)objId
                               withTextField:(BOOL)bIncludeTextField
                             withPlaceHolder:(NSString *)placeHolder;

@end
