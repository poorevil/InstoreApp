//
//  MBSPopupItem.h
//  MBSMapViewController
//
//  Created by sunyifei on 3/26/13.
//
//

#import <Foundation/Foundation.h>

typedef struct _popupInfo{
    CGPoint rootPoint;
    CGPoint contentOffset;
    NSString *strTitle;
    NSString *strDetail;
    BOOL fHasDetailInfo;
    BOOL fIsNewStore;
}STRUCT_POPUP_INFO;

@protocol MBSPopupItem //must be a UIView


-(BOOL)fCustomized; //return TRUE if you implements this protocol
-(void)initPopUpItemWithInfo:(STRUCT_POPUP_INFO)popInfo;
@end