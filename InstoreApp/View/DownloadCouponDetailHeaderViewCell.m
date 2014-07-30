//
//  DownloadCouponDetailHeaderViewCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-19.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DownloadCouponDetailHeaderViewCell.h"

@implementation DownloadCouponDetailHeaderViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDownloadCouponModel:(DownloadCouponModel *)downloadCouponModel{
    [_downloadCouponModel release];
    _downloadCouponModel = [downloadCouponModel retain];
    
    if (downloadCouponModel) {
        self.imageIcon.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/120*120.png", downloadCouponModel.imageURL]];
        self.labTitle.text = downloadCouponModel.title;
        CGSize sizeMax = CGSizeMake(180, 21);
        CGSize size = [downloadCouponModel.title sizeWithFont:_labTitle.font constrainedToSize:sizeMax lineBreakMode:NSLineBreakByCharWrapping];
        if (size.width > sizeMax.width) {
            self.labFree.frame = CGRectMake(262, 10, 30, 20);
        }else{
            CGRect frame = self.labFree.frame;
            frame.origin.x = 93 + size.width + 2;
            self.labFree.frame = frame;
        }
        self.labInstruction.text = downloadCouponModel.instruction;
        self.imageCode.imageURL = [NSURL URLWithString:downloadCouponModel.barCodeUrl];
        self.labCode.text = downloadCouponModel.couponCode;
        
    }
}

- (void)dealloc {
    [_imageIcon release];
    [_labTitle release];
    [_labFree release];
    [_imageCode release];
    [_labCode release];
    [_labInstruction release];
    self.downloadCouponModel = nil;
    
    [super dealloc];
}
@end
