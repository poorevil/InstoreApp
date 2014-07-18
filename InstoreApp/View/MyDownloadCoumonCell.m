//
//  MyDownloadCoumonCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyDownloadCoumonCell.h"
#import "NSDate+DynamicDateString.h"

@implementation MyDownloadCoumonCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCouponModel:(DownloadCouponModel *)couponModel{
    if (couponModel) {
        [_couponModel release];
        _couponModel = [couponModel retain];
        
        self.imageIcon.imageURL = [NSURL URLWithString:[NSURL URLWithString:[NSString stringWithFormat:@"%@/120*120.png",couponModel.imageURL]]];
        self.labTitle.text = couponModel.title;
        CGSize sizeMax = CGSizeMake(180, 21);
        CGSize size = [couponModel.title sizeWithFont:_labTitle.font constrainedToSize:sizeMax lineBreakMode:NSLineBreakByCharWrapping];
        if (size.width > sizeMax.width) {
            self.labMianFei.frame = CGRectMake(262, 10, 30, 20);
        }else{
            CGRect frame = self.labMianFei.frame;
            frame.origin.x = 80 + size.height + 2;
            self.labMianFei.frame = frame;
        }
        
        self.labInstruction.text = couponModel.instruction;
        // 优惠券状态 <0, "未消费/正常">, <1, "已消费">, <3, "已过期">
        switch (couponModel.couponStatus) {
            case 0:{
                self.labDate.text = [NSString stringWithFormat:@"%@~%@",[couponModel.startTime toDateString],[couponModel.endTime toDateString]];
            }
                break;
            case 1:{
                self.labDate.text = [NSString stringWithFormat:@"%@~%@",[couponModel.startTime toDateString],[couponModel.endTime toDateString]];
            }
                break;
            case 3:{
                self.labDate.hidden = YES;
                self.imageGuoQi.hidden = NO;
                self.accessoryType = UITableViewCellAccessoryNone;
            }
                break;
            default:
                break;
        }
    }
}


- (void)dealloc {
    self.couponModel = nil;
    [_imageIcon release];
    [_labTitle release];
    [_labInstruction release];
    [_labDate release];
    [_imageGuoQi release];
    [_labMianFei release];
    [super dealloc];
}
@end
