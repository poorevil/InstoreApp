//
//  StoreInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol StoreInterfaceDelegate <NSObject>

-(void)getStoreListDidFinished:(NSArray *)resultList
                    totalCount:(NSInteger)totalCount
                    storeCount:(NSInteger)storeCount    //用户关注的商家数
                   currentPage:(NSInteger)currentPage
                      category:(NSString *)category;    //商户大分类 默认"Department"

-(void)getStoreListDidFailed:(NSString *)errorMessage;

@end

@interface StoreInterface : BaseInterface <BaseInterfaceDelegate>
@property (nonatomic,assign) id<StoreInterfaceDelegate> delegate;
@property (nonatomic, retain) NSString *category;

-(void)getStoreListByAmount:(NSInteger)amount
                       page:(NSInteger)page
                   category:(NSString *)category; //商户大分类 默认"Department";
//复杂查询
-(void)getStoreListByFloorId:(NSInteger)fid
                         cid:(NSInteger)cid
                  buildingId:(NSInteger)bid
                     order:(NSString *)order
                    category:(NSString *)category //商户大分类 默认"Department"
                    amount:(NSInteger)amount
                      page:(NSInteger)page;

@end
