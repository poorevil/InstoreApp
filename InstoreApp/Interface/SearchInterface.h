//
//  SearchInterface.h
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol SearchInterfaceDelegate <NSObject>

-(void)searchDidFinished:(NSArray*)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
-(void)searchDidFailed:(NSString*)errorMessage;

@end

@interface SearchInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<SearchInterfaceDelegate> delegate;

-(void)searchKeyword:(NSString*) keyword
                type:(NSInteger)type
             orderBy:(NSString *)order
              amount:(NSInteger)amount
                page:(NSInteger)pageNum;

@end
