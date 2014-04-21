//
//  MBSPopUpView.h
//  SmartMall
//
//  Created by sunyifei on 11/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBSPopupItem.h"

@class MBSErrorCorrection;
@interface MBSPopUpView : UIImageView <MBSPopupItem, UIActionSheetDelegate> {
    CGRect switchResponseRect;
    UITextField *newStoreTextField;
}

@property (nonatomic, retain) NSString *popUpTitle;
@property (nonatomic, retain) NSString *popUpDetail;

@property (nonatomic) BOOL isNewStore;

- (id)initWithFrame:(CGRect)frame withLeftBtnWidth:(float)lBtnWidth;
- (void)switchToStoreDetailView;

@end
