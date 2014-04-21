//
//  DataType.h
//  SmartMall
//
//  Created by dujianping on 8/24/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>


enum CITYMAP_STATE {
    CITYMAP_STATE_EMPTY = 0,
    CITYMAP_STATE_DOWNLOADING = 1,
    CITYMAP_STATE_SUSPEND = 2,
    CITYMAP_STATE_FINISH = 3,
    CITYMAP_STATE_NEEDUPDATE = 4,
};

@interface StoreGroupLabel: NSObject {
    char label;
    NSInteger index;//起始index
}
@property (nonatomic, assign) char label;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSMutableArray *subItems;

@end

//Will be used to cache the brand list data
@interface BrandListItem : NSObject {
    NSInteger brandId;
    NSString *brandName;
    NSString *brandBranchCount;
    NSString *brandLike;
    NSString *brandDiscount;
    NSString *brandLogoUrl;
}

@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, retain) NSString *brandName;
@property (nonatomic, retain) NSString *brandBranchCount;
@property (nonatomic, retain) NSString *brandDiscount;
@property (nonatomic, retain) NSString *brandLike;
@property (nonatomic, retain) NSString *brandLogoUrl;

@end

//Will be used to cache the mall list data
@interface CategrayListItem : NSObject {
    NSInteger categoryId;
    NSString *categrayName;
    NSString *categrayScope;
    NSString *categrayStores;
    NSString *categrayLogoUrl;
}

@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, retain) NSString *categrayName;
@property (nonatomic, retain) NSString *categrayScope;
@property (nonatomic, retain) NSString *categrayStores;
@property (nonatomic, retain) NSString *categrayLogoUrl;

@end

//Brand branch to describe the branch.
@interface BrandBranch : NSObject {
    NSInteger spId;
    NSInteger frno;
    long long storeId;
    NSString *mallName;
    NSString *mallDistance;
    NSString *brandName;
    NSString *discount;
    NSString *logoUrl;
}
@property (nonatomic, assign) NSInteger spId;
@property (nonatomic, assign) NSInteger frno;
@property (nonatomic, assign) long long storeId;
@property (nonatomic, retain) NSString *mallName;
@property (nonatomic, retain) NSString *mallDistance;
@property (nonatomic, retain) NSString *brandName;
@property (nonatomic, retain) NSString *discount;
@property (nonatomic, retain) NSString *logoUrl;

@end

@interface BrandDetail : NSObject {
    NSInteger brandId;
    NSString *brandName;
    NSString *brandDiscount;
    NSString *brandDescription;
    NSMutableArray *brandBranches;
}

@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, retain) NSString *focusCount;
@property (nonatomic, retain) NSString *brandName;
@property (nonatomic, retain) NSString *brandLogoUrl;
@property (nonatomic, retain) NSString *brandDiscount;
@property (nonatomic, retain) NSString *brandDescription;
@property (nonatomic, retain) NSMutableArray *brandBranches;
@property (nonatomic, assign) BOOL isUserFocus;

@end

@interface StoreListItem : NSObject {
    long long storeId;
    NSInteger floorId;
    NSString *brandName;
    NSString *mallName;
    NSString *discount;
    NSString *brandLogoUrl;
}

@property (nonatomic, assign) long long storeId;
@property (nonatomic, assign) NSInteger floorId;
@property (nonatomic, assign) BOOL isUserFocus;
@property (nonatomic, retain) NSString *storeNum;
@property (nonatomic, retain) NSString *displayedFloorMarker;
@property (nonatomic, retain) NSString *focusCount;
@property (nonatomic, retain) NSString *brandName;
@property (nonatomic, retain) NSString *mallName;
@property (nonatomic, retain) NSString *discount;
@property (nonatomic, retain) NSString *brandLogoUrl;

@end

@interface ActivityInfo : NSObject {
    NSString *duration;
    NSString *discount;
    NSString *activityImageUrl;
    NSString *mallName;
    NSString *brandName;
    NSString *state;
}

@property (nonatomic, retain) NSString *duration;
@property (nonatomic, retain) NSString *discount;
@property (nonatomic, retain) NSString *activityImageUrl;
@property (nonatomic, retain) NSString *mallName;
@property (nonatomic, retain) NSString *brandName;
@property (nonatomic, retain) NSString *state;

@end

@interface Mall : NSObject {
}

@property (nonatomic, assign) NSInteger mallId;
@property (nonatomic, assign) NSInteger mallType;
@property (nonatomic, retain) NSString  *mallName;
@property (nonatomic, retain) NSString  *mallLat;
@property (nonatomic, retain) NSString  *mallLon;
@property (nonatomic, retain) NSString  *mallDistance;
@property (nonatomic, retain) NSString  *mallAddr;
@property (nonatomic, retain) NSString  *mallDiscountNum;
@property (nonatomic, retain) NSString  *mallWeiboNickName;
@property (nonatomic, retain) NSString  *mallLogoUrl;
@property (nonatomic, retain) NSString *focusCount;
@property (nonatomic, assign) BOOL isUserFocus;
@property (nonatomic, assign) NSInteger mallClicks;
@property (nonatomic, assign) NSInteger partnerType;

@end

@interface CityInfo : NSObject {
    NSString  *cityName;
    NSString  *cityCode;
    NSString  *cityLat;
    NSString  *cityLon;
}

@property (nonatomic, retain) NSString  *cityName;
@property (nonatomic, retain) NSString  *cityCode;
@property (nonatomic, retain) NSString  *cityLat;
@property (nonatomic, retain) NSString  *cityLon;
@property (nonatomic) float  mapSize;
@property (nonatomic) enum CITYMAP_STATE downloadState;

@end

@interface MallInfo : NSObject {
    
}

@property (nonatomic, assign) NSInteger mallId;
@property (nonatomic, retain) NSString  *mallTel;
@property (nonatomic, retain) NSString  *mallAddress;
@property (nonatomic, retain) NSString  *mallDesc;
@property (nonatomic, retain) NSString  *mallPublicBus;
@property (nonatomic, retain) NSString  *mallOpenTime;
@property (nonatomic, retain) NSString *focusCount;
@property (nonatomic, assign) BOOL isUserFocus;

@end

@interface DiscountInfo : NSObject {
}

@property (nonatomic, assign) NSInteger mallId;
@property (nonatomic, retain) NSString  *discountOwnerName;
@property (nonatomic, retain) NSString  *discountOwnerLogoUrl;
@property (nonatomic, retain) NSString  *discountTitle;
@property (nonatomic, retain) NSString  *discountContent;
@property (nonatomic, retain) NSString  *discountRange;
@property (nonatomic, retain) NSString  *discountSmallImageUrl;
@property (nonatomic, retain) NSString  *discountBigImageUrl;
@property (nonatomic, retain) NSString  *discountState;
@property (nonatomic, retain) NSString *discountSourceName;
@property (nonatomic, retain) NSString *discountSourceUrl;
@property (nonatomic, retain) NSString *startData;
@property (nonatomic, retain) NSString *endDate;
@property (nonatomic, assign) double distanceToUser;

@end

@interface UserInfo : NSObject {
    NSString  *userNickName;
    NSString  *userEmail;
    NSString  *userSex;
    NSString  *userHeaderUrl;
}

enum UserType {
    USER_TYPE_DIANDAO = 1,
    USER_TYPE_SINAWEIBO = 2,
    USER_TYPE_RENREN = 3,
};

@property (nonatomic, assign) enum UserType userType;
@property (nonatomic, retain) NSString *userNickName;
@property (nonatomic, retain) NSString *userEmail;
@property (nonatomic, retain) NSString *userSex;
@property (nonatomic, retain) NSString *userHeaderUrl;
@property (nonatomic, retain) NSString *access_token;

@end

@interface SearchItem : NSObject {
}

@property (nonatomic, retain) NSString *itemName;
@property (nonatomic, retain) NSString *itemDescription;
@property (nonatomic, assign) long long itemId;
@property (nonatomic, assign) NSInteger itemType;
@property (nonatomic, retain) NSString *itemLogoUrl;

@end

@interface ServerState : NSObject {
}

@property (nonatomic, retain) NSString *hostAddress;
@property (nonatomic, assign) BOOL forceUpdate;
@property (nonatomic, retain) NSString *appUpdateURL;

@end

@interface FocusDiscount : NSObject {
}

enum OBJ_TYPE {
    OBJ_TYPE_MALL = 1,
    OBJ_TYPE_BRAND = 2,
    OBJ_TYPE_STORE = 4,
    OBJ_TYPE_MALLSTORES = 5,
};

@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) enum OBJ_TYPE itemType;
@property (nonatomic, retain) NSString *itemFocusCount;
@property (nonatomic, retain) NSString *itemDiscountCount;
@property (nonatomic, assign) BOOL isUserFocus;

    
@end

@interface IndoorPOI : NSObject

@property (nonatomic, assign) long long poiId;
@property (nonatomic, assign) NSInteger poiFloorNum;
@property (nonatomic, retain) NSString *poiFloorName;
@property (nonatomic, retain) NSString *poiRoomNum;
@property (nonatomic, retain) NSString *poiName;
@property (nonatomic, retain) NSString *poiAlias;
@property (nonatomic, retain) NSString *poiLogo;
@property (nonatomic, assign) BOOL isUserFocus;
@property (nonatomic, assign) NSInteger poiFocusCount;

@end
