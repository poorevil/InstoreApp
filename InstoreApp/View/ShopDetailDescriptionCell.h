//
//  ShopDetailDescriptionCell.h
//  InstoreApp
//
//  Created by han chao on 14-4-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopDetailDescriptionCellDelegate <NSObject>

-(void)isShowDetailMessage:(BOOL)show;

@end

@interface ShopDetailDescriptionCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *descLabel;
@property (nonatomic,assign) id<ShopDetailDescriptionCellDelegate> delegate;

@property (nonatomic,assign) BOOL isShowDetailMessage;

-(IBAction)moreBtnAction:(id)sender;

@end
