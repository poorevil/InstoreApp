//
//  MBSPopUpView.h
//  SmartMall
//
//  Created by sunyifei on 11/3/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBSPopupItem.h"

@class MBSErrorCorrection;
@interface MBSPopUpContainer : UIImageView <MBSPopupItem, UIActionSheetDelegate> {
    CGRect switchResponseRect;
    UITextField *newStoreTextField;
}

@property (nonatomic, retain) NSString *popUpTitle;
@property (nonatomic, retain) NSString *popUpDetail;

@property (nonatomic) CGPoint parentContentOffset;
@property (nonatomic) CGPoint rootMapPoint;

@property (nonatomic, retain) UIImage *addIcon;
@property (nonatomic, retain) UIImage *arrowIcon;

@property (nonatomic) BOOL isNewStore;
@property (nonatomic, retain) MBSErrorCorrection *errorReporter;


+ (id)createPopUpItemWithInfo:(STRUCT_POPUP_INFO)popInfo;
@end
