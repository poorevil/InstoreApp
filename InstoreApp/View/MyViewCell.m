//
//  MyViewCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyViewCell.h"

@implementation MyViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTextDict:(NSDictionary *)textDict{
    if (textDict) {
        NSString *title = [textDict objectForKey:@"title"];
        self.labTitle.text = title;
        
        UIFont *font = self.labTitle.font;
        CGSize size = CGSizeMake(200, 21);
        CGSize textLabelSize = [title sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        CGRect frameCount = self.labCount.frame;
        frameCount.origin.x += textLabelSize.width;
        self.labCount.frame = frameCount;
        
        CGRect frameTitle = self.labTitle.frame;
        frameTitle.size.width = textLabelSize.width;
        self.labTitle.frame = frameTitle;
        
        self.labCount.text = [textDict objectForKey:@"count"];
    }
}

- (void)dealloc {
    [_labTitle release];
    [_labCount release];
    self.textDict = nil;
    
    [super dealloc];
}
@end
