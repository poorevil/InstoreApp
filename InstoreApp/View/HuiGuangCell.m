//
//  HuiGuangCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "HuiGuangCell.h"


@implementation HuiGuangCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.labComment = [[[RTLabel alloc]initWithFrame:CGRectMake(25, 5, 140, 50)]autorelease];
//    self.labComment.numberOfLines = 2;
    self.labComment.font = [UIFont systemFontOfSize:10];
    [self.commentView addSubview:self.labComment];
    
}

-(void)setHuiGuangModel:(HuiGuangModel *)huiGuangModel{
    [_huiGuangModel release];
    _huiGuangModel = [huiGuangModel retain];
    
    UIImage *image;
    if (huiGuangModel.storeOrSaler) {
        image = [UIImage imageNamed:@"main_huiguang_cell_bg_saler.png"];
    }else{
        image = self.imageStoreOrSaler.image;
    }
    //TODO:拉伸图片
    
    self.imageStoreOrSaler.image = image;
    
    self.imageIcon.imageURL = [NSURL URLWithString:huiGuangModel.imageIconURL];
    self.Image.imageURL = [NSURL URLWithString:huiGuangModel.imageURL];
    
    
    self.labTitle.text = huiGuangModel.title;
    //title Frame
    CGSize titleSizeMax = CGSizeMake(140, 100);
    CGSize titleSize = [self.labTitle.text sizeWithFont:self.labTitle.font constrainedToSize:titleSizeMax lineBreakMode:NSLineBreakByWordWrapping];
    CGRect titleFrame = self.labTitle.frame;
    
    if (titleSize.height > 30) {
        CGRect commentViewFrame = self.commentView.frame;
        CGRect parentFrame = self.parentView.frame;
        
        titleFrame.size.height = 34;
        parentFrame.size.height += 17;
        commentViewFrame.origin.y += 17;
        
        self.commentView.frame = commentViewFrame;
        self.parentView.frame = parentFrame;
    }else{
        titleFrame.size.height = 17;
    }
    self.labTitle.frame = titleFrame;
    

    if (huiGuangModel.commentCount > 0) {
        self.labComment.text = [NSString stringWithFormat:@"<font color='#F49B27'>%@:</font> <font color=#D2D2D2>%@</font>",[[huiGuangModel.commentList lastObject] objectForKey:@"name" ],[[huiGuangModel.commentList lastObject] objectForKey:@"comment"]];
        
        [self.btnAllComment setTitle:[NSString stringWithFormat:@"全部 %d 条评论",huiGuangModel.commentCount] forState:UIControlStateNormal];
    }else{
        self.commentView.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    //@"<font color='#CCFF00'>Text with</font> <font color=purple>different colours</font>"
    
    [_imageIcon release];
    [_Image release];
    [_labTitle release];
    [_btnAllComment release];
    [_commentView release];
    [_parentView release];
    self.labComment = nil;
    self.huiGuangModel = nil;
    
    [_imageStoreOrSaler release];
    [super dealloc];
}
- (IBAction)btnAllCommentAction:(UIButton *)sender {
}
@end
