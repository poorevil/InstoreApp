//
//  ColorManager.h
//  MBSMap
//
//  Created by sunyifei on 9/22/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorManager : NSObject {

}
@property (nonatomic, assign) NSString *textRealTimeColor;

@property (nonatomic, copy) NSString *storeFillColor; //default
@property (nonatomic, copy) NSString *emptyStrokeColor;
@property (nonatomic, copy) NSString *emptyFillColor;
@property (nonatomic, copy) NSString *squareFillColor;
@property (nonatomic, copy) NSString *selectedFillColor;
@property (nonatomic, copy) NSString *unUsedFillColor;
@property (nonatomic, copy) NSString *strokeColor;

@property (nonatomic, copy) NSString *textColor;
@property (nonatomic, copy) NSString *screenIndicatorBoarderColor;
@property (nonatomic, copy) NSString *iconFillColor;
@property (nonatomic, copy) NSString *iconStrokeColor;
@property (nonatomic, copy) NSString *iconHLStrokeColor;
@property (nonatomic, copy) NSString *iconHLFillColor;
@property (nonatomic, copy) NSString *bgFillColor;
@property (nonatomic, copy) NSString *bgStrokeColor;

@property (nonatomic, copy) NSString *gateStrokeColor;
@property (nonatomic, copy) NSString *gateFillColor;

@property (nonatomic, copy) NSString *txtBorderStrokeColor;
@property (nonatomic, copy) NSString *txtBorderFillColor;


+(ColorManager *)getInstance;
+(CGColorRef)colorFromHexString:(NSString *)strColor;
-(void)resetColors;
-(void)setToUseAirportColors;

@end
