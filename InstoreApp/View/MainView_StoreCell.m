//
//  MainView_ StoreCell.m
//  InstoreApp
//
//  Created by evil on 14-6-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_StoreCell.h"

#import "StoreModel.h"
#import "EGOImageView.h"

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
    
    CGFloat lastY = 0;
    for (NSInteger i = 0; i < self.dataList.count; i++) {
        StoreModel *sm = [self.dataList objectAtIndex:i];
        
        UIView *tileView = [self createTileView:sm];
        CGRect frame = tileView.frame;
        if (i % 2 == 0) {
            frame.origin.x = self.frame.size.width/2;
        }else{
            frame.origin.x = 0;
        }
        frame.origin.y = lastY + frame.size.height;
        
        tileView.frame = frame;
        
        [self.parentView addSubview:tileView];
    }
}

-(UIView *)createTileView:(StoreModel *)sm
{
    UIView *tileView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width-2)/2, 50)] autorelease];
    EGOImageView *imageView = [[[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)] autorelease];
    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/100*100.png",sm.imageUrl]];
    [tileView addSubview:imageView];
    
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70, 20, 50, 21)] autorelease];
    titleLabel.text = sm.title;
    [tileView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70, 60, 50, 21)] autorelease];
    subTitleLabel.text = @"blablabla";
    [tileView addSubview:subTitleLabel];
    
    //TODO:tap action
    
    return tileView;
}

@end
