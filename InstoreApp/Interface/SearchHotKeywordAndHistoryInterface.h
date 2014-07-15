//
//  SearchHotKeywordInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol SearchHotKeywordInterfaceDelegate <NSObject>

-(void)getSearchHotKeywordAndHistoryListDidFinished:(NSArray *)hot AndHistory:(NSArray *)history;
-(void)getSearchHotKeywordAndHistoryListListDidFailed:(NSString *)errorMsg;

@end

@interface SearchHotKeywordAndHistoryInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<SearchHotKeywordInterfaceDelegate>delegate;
-(void)getSearchHotKeywordAndHistoryList;

@end
