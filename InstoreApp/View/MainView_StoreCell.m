//
//  MainView_ StoreCell.m
//  InstoreApp
//
//  Created by evil on 14-6-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_StoreCell.h"
#import "EGOImageView.h"
#import "StoreModel.h"


@implementation MainView_StoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataList:(NSArray *)dataList
{
    [_dataList release];
    _dataList = [dataList retain];
    
    CGPoint lastPoint = CGPointMake(0, 0);
    for (NSInteger i = 0; i < self.dataList.count; i++) {
        StoreModel *sm = [self.dataList objectAtIndex:i];
        
        EGOImageView *imageView = [[[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)] autorelease];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 4;
        imageView.layer.borderWidth = 0.4f;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.clipsToBounds = YES;
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/100*100.png",sm.imageUrl]];
        
        CGRect frame = imageView.frame ;
        frame.origin = lastPoint;
        
        if (i != 0 && i % 4 == 0) {
            lastPoint.y = 56 + 10;
            lastPoint.x = 0;
        }else{
            lastPoint.x += 56 + 5;
        }
        
        imageView.frame = frame;
        
        [self.parentView addSubview:imageView];
    }
}


@end
