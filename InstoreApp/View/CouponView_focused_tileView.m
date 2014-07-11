//
//  CouponView_focused_tileView.m
//  InstoreApp
//
//  Created by evil on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponView_focused_tileView.h"

#import "CouponModel.h"
#import "StoreModel.h"
#import "EGOImageView.h"
#import "NSDate+DynamicDateString.h"

@implementation CouponView_focused_tileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setCm:(CouponModel *)cm
{
    [_cm release];
    _cm = [cm retain];
    
    if (self.cm) {
        self.logoImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/100*100.png",cm.store.imageUrl]];
        self.logoNameLabel.text = cm.store.title;
        if (cm.hotTag.length > 0) {
            self.tagLabel.superview.hidden = NO;
            self.tagLabel.text = cm.hotTag;
        }else{
            self.tagLabel.superview.hidden = YES;
        }
        
        self.couponImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/400*400.png",cm.imageUrl]];
        [self setupTypeLabel:cm.promotionType andTypeLabel:self.promotionTypeLabel];
        self.titleLabel.text = cm.title;
        self.endTimeLabel.text = [cm.endTime toDateString];//TODO:date
        UIImage *favorIcon = nil;
        if (cm.isFocus) {
            favorIcon = [UIImage imageNamed:@"cellview_favor_yes_btn"];
        }else{
            favorIcon = [UIImage imageNamed:@"cellview_favor_no_btn"];
        }
        [self setupBtn:self.favorBtn
                 title:[NSString stringWithFormat:@"%d",cm.focusCount]
                 state:UIControlStateNormal
                  icon:favorIcon];
        [self setupBtn:self.shareBtn
                 title:[NSString stringWithFormat:@"%d",0]
                 state:UIControlStateNormal
                  icon:[UIImage imageNamed:@"cellview_share_btn"]];
        
    }
}

-(void)setupBtn:(UIButton *)btn
          title:(NSString *)title
          state:(UIControlState)state
           icon:(UIImage*)icon{
    [btn setTitle:title forState:state];
    [btn setImage:icon forState:state];
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.frame.size.width / 2 -btn.imageView.frame.size.width),0, btn.frame.size.width / 2)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,btn.frame.size.width / 2-10, 0, 10)];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    
}

#define HUI_COLOR   [UIColor colorWithRed:231/255.0f green:51/255.0f blue:60/255.0f alpha:1]
#define QUAN_COLOR   [UIColor colorWithRed:51/255.0f green:163/255.0f blue:230/255.0f alpha:1]
#define TUAN_COLOR   [UIColor colorWithRed:239/255.0f green:137/255.0f blue:31/255.0f alpha:1]
-(void)setupTypeLabel:(NSInteger)type andTypeLabel:(UILabel *)label
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
    
    label.superview.backgroundColor = bgColor;
    label.text = text;
}

-(void)dealloc
{
    self.logoImageView = nil;
    self.logoNameLabel = nil;//品牌名称
    self.couponImageView = nil;
    self.tagLabel = nil;//推荐标签
    self.promotionTypeLabel = nil;//团、券、惠
    self.titleLabel = nil;
    self.watchImageView = nil;
    self.endTimeLabel = nil;
    self.favorBtn = nil;
    self.shareBtn = nil;
    self.parentView = nil;
    
    [super dealloc];
}
@end
