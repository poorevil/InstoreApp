//
//  FoodItemCell.m
//  InstoreApp
//
//  Created by evil on 14-6-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FoodItemCell.h"
#import "StoreModel.h"
#import "EGOImageView.h"
#import "PositionModel.h"
#import "FloorModel.h"
#import "AppDelegate.h"

#import "StoreDetail_RestaurantViewController.h"

@implementation FoodItemCell

- (void)awakeFromNib
{
    // Initialization code
    UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)] autorelease];
    [self addGestureRecognizer:tap];
    
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)tapAction:(id)gesture
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    StoreDetail_RestaurantViewController *sdrvc = [[StoreDetail_RestaurantViewController alloc] initWithNibName:@"StoreDetail_RestaurantViewController" bundle:nil];
    sdrvc.shopId = self.storeModel.sid;
    sdrvc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:sdrvc animated:YES];
    sdrvc.hidesBottomBarWhenPushed = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStoreModel:(StoreModel *)storeModel
{
    [_storeModel release];
    _storeModel = [storeModel retain];
    
    self.titleLabel.text = self.storeModel.title;
    CGSize size = [self.storeModel.title sizeWithFont:self.titleLabel.font
                                    constrainedToSize:CGSizeMake(200,
                                                                 self.titleLabel.frame.size.height)
                                        lineBreakMode:self.titleLabel.lineBreakMode];
    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x,
                                       self.titleLabel.frame.origin.y,
                                       size.width,
                                       size.height);
    
    for (UIView *v in self.contentView.subviews) {
        if (v.tag == 999) {
            [v removeFromSuperview];
        }
    }
    if (self.storeModel.promotionTypes.count > 0) {
        NSInteger i = 0;
        for (NSNumber *promotionType in self.storeModel.promotionTypes) {
            UIView *tagView = [self setupTypeLabel:[promotionType integerValue]];
            tagView.tag = 999;
            CGRect frame = tagView.frame;
            frame.origin.y = self.titleLabel.frame.origin.y+(self.titleLabel.frame.size.height-frame.size.height)/2;
            frame.origin.x = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 7 +
                                i * frame.size.width + i*2;
            tagView.frame = frame;
            
            [self.contentView addSubview:tagView];
            i++;
        }
    }
    
    self.subTitleLabel.text = self.storeModel.slogan;
    self.logoImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/120*120.png",
                                                        self.storeModel.logoUrl]];
    NSString *avgPrice = @"";
    if (!self.storeModel.avgPrice) {
        avgPrice = @"人均:--";
    }else{
        avgPrice = [NSString stringWithFormat:@"人均:%d",self.storeModel.avgPrice];
    }
    self.priceLabel.text = avgPrice;
    self.addressLabel.text = self.storeModel.position.floor.fName;
    self.favorLabel.text = [NSString stringWithFormat:@"%d",self.storeModel.followerCount];

}

-(UIView *)setupTypeLabel:(NSInteger)type
{
    UIColor *bgColor = nil;
    NSString *text = nil;
    switch (type) {
        case 1: //惠
            bgColor = HUI_COLOR;
            text = @"惠";
            break;
        case 2: //券
            bgColor = QUAN_COLOR;
            text = @"券";
            break;
        case 3: //团
            bgColor = TUAN_COLOR;
            text = @"团";
            break;
    }
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 14, 14)] autorelease];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    UIView *parentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)] autorelease];
    [parentView addSubview:label];
    
    label.superview.backgroundColor = bgColor;
    label.text = text;
    
    return parentView;
}

-(void)dealloc
{
    self.logoImageView = nil;
    self.titleLabel = nil;
    self.subTitleLabel = nil;
    self.priceLabel = nil;
    self.addressLabel = nil;
    self.favorLabel = nil;
    
    self.storeModel = nil;
    
    [super dealloc];
}

@end
