//
//  BaseDataType.h
//  MBSMapViewController
//
//  Created by sunyifei on 3/29/13.
//
//

#import <Foundation/Foundation.h>

@interface BaseStoreInfo : NSObject {
    long long storeId;
    NSInteger frno;
    NSInteger mallId;
    NSString *brandName;
}

@property (nonatomic, assign) long long storeId;
@property (nonatomic, assign) NSInteger frno;
@property (nonatomic, assign) NSInteger mallId;
@property (nonatomic, retain) NSString *brandName;

@end

@interface StoreInfo : BaseStoreInfo {
    NSString *mallName;
    NSString *mallAddr;
    NSString *mallLat;
    NSString *mallLon;
    NSString *brandLogoUrl;
    NSString *brandDesc;
    NSString *storePos;
    NSString *storeTel;
    NSString *discountTitle;
    NSString *discountDesc;
    NSString *focusCount;
    BOOL isFocus;
}

@property (nonatomic, retain) NSString *mallName;
@property (nonatomic, retain) NSString *mallAddr;
@property (nonatomic, retain) NSString *mallLat;
@property (nonatomic, retain) NSString *mallLon;
@property (nonatomic, retain) NSString *brandLogoUrl;
@property (nonatomic, retain) NSString *brandDesc;
@property (nonatomic, retain) NSString *storePos;
@property (nonatomic, retain) NSString *storeTel;
@property (nonatomic, retain) NSString *discountTitle;
@property (nonatomic, retain) NSString *discountDesc;
@property (nonatomic, retain) NSString *focusCount;
@property (nonatomic, assign) BOOL isFocus;

@end
