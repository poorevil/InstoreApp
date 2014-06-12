//
//  MainView_ CategoryCell.m
//  InstoreApp
//
//  Created by evil on 14-6-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_CategoryCell.h"
#import "CategoryModel.h"
#import "EGOImageView.h"

@implementation MainView_CategoryCell

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
        CategoryModel *cm = [self.dataList objectAtIndex:i];
        
        UIView *tileView = [self createTileView:cm];
        CGRect frame = tileView.frame ;
        frame.origin.y = lastY - (i / 2)*2;
        if (i % 2 == 0) {
            frame.origin.x = -2;
        }else{
            frame.origin.x = self.frame.size.width/2-2;
            lastY += frame.size.height;
        }
        
        tileView.frame = frame;
        
        [self.parentView addSubview:tileView];
    }
}

-(UIView *)createTileView:(CategoryModel *)cm
{
    UIView *tileView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width-2)/2+4, 60)] autorelease];
    tileView.layer.borderColor = [UIColor colorWithRed:247/255.0f
                                                 green:247/255.0f
                                                  blue:247/255.0f
                                                 alpha:1].CGColor;
    tileView.layer.borderWidth = 2.0f;
    EGOImageView *imageView = [[[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",cm.imageUrl]];
    [tileView addSubview:imageView];
    
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(68, 10, 100, 21)] autorelease];
    titleLabel.text = cm.cName;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [tileView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(68, 31, 100, 21)] autorelease];
    subTitleLabel.text = cm.subhead;
    subTitleLabel.font = [UIFont systemFontOfSize:11];
    subTitleLabel.textColor = [UIColor darkGrayColor];
    [tileView addSubview:subTitleLabel];
    
    //TODO:tap action
    
    return tileView;
}


@end
