//
//  MBSPopupDelegate.h
//  MBSMapViewController
//
//  Created by sunyifei on 3/29/13.
//
//

#import <Foundation/Foundation.h>

@protocol MBSPopupDelegate <NSObject>

//@required
//-(void)popUpDismissWithNewStoreAlertForStoreId:(long long)storeId;
//-(void)createShareIndicator:(CGPoint)offset;


@optional
 //气球最左边的定制view，在设置MBSPopup的fHasLeftAccessoryView 为TRUE时需要提供此方法
-(UIView*)getLeftAccessoryView;

 //设置定制左btn的大小， 根据leftBtnSize和leftAccessoryView的frame即可确定btn边界和leftAccessoryView的边界
-(CGSize)getLeftBtnSize;

@end
