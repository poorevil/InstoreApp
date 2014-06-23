//
//  StoreDetail_headerView.h
//  InstoreApp
//
//  Created by evil on 14-6-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;
@class StoreModel;
@interface StoreDetail_headerView : UIView

@property (nonatomic, retain) IBOutlet EGOImageView *logoImageView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain) IBOutlet UILabel *avgPrice;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UILabel *telLabel;


@property (nonatomic, retain) StoreModel *storeModel;
@end
