//
//  MBSMBSGlobal.h
//  SmartMall
//
//  Created by dujianping on 9/14/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import "DataType.h"
#import "Reachability.h"
#import "MobiConnection.h"
#import "TimeStamp.h"

#define KEY_HTTPACCESS_TOKEN       @"accessToken_Saved"
#define KEY_HTTPACCESS_LASTTIME    @"accessToken_lastTime"
#define KEY_HTTPACCESS_TIMEGAP     @"accessToken_timeExpireGap"
#define INDOORMAP_POPSHARE_INTRODUCTION   @"filter_popupshare"


#define ACTIONSHEET_CANCEL                 @"取消"
#define ACTIONSHEET_SHARE_WEIXIN           @"分享给微信好友"

#define SESSION_CHANGED       @"session_changed"
#define ALLICON_GOT           @"allicon_got"

//typedef NS_ENUM(NSInteger, DianDaoUnitType) {
//    DIANDAO_UNIT_UNKNOWN        = 0,   //未知类型
//    DIANDAO_UNIT_MALL           = 1,   //商场
//    DIANDAO_UNIT_HOSPITAL       = 8,   //医院
//    DIANDAO_UNIT_MUSEUM         = 16,  //博物馆
//    DIANDAO_UNIT_FURNITURE      = 32,  //家具建材城
//    DIANDAO_UNIT_COLLEGE        = 64,  //大学
//    DIANDAO_UNIT_LIBRARY        = 128, //图书馆
//    DIANDAO_UNIT_AIRPORT        = 256,   //机场
//    DIANDAO_UNIT_TRAIN          = 512,   //火车站
//};

enum DIANDAO_UNIT_TYPE  {
    DIANDAO_UNIT_UNKNOWN        = 0,   //未知类型
    DIANDAO_UNIT_MALL           = 1,   //商场
    DIANDAO_UNIT_HOSPITAL       = 8,   //医院
    DIANDAO_UNIT_MUSEUM         = 16,  //博物馆
    DIANDAO_UNIT_FURNITURE      = 32,  //家具建材城
    DIANDAO_UNIT_COLLEGE        = 64,  //大学
    DIANDAO_UNIT_LIBRARY        = 128, //图书馆
    DIANDAO_UNIT_AIRPORT        = 256,   //机场
    DIANDAO_UNIT_TRAIN          = 512,   //火车站
};