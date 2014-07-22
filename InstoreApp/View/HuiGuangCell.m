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
    
    self.labComment = [[[RTLabel alloc]initWithFrame:CGRectMake(100, 80, 30, 50)]autorelease];
//    self.labComment = 0;
    [self.commentView addSubview:self.labComment];
    
}

-(void)setHuiGuangModel:(HuiGuangModel *)huiGuangModel{
    [_huiGuangModel release];
    _huiGuangModel = [huiGuangModel retain];
    
    UIImage *image;
    if (huiGuangModel.storeOrSaler) {
        image = [UIImage imageNamed:@""];
    }else{
        image = self.imageStoreOrSaler.image;
    }
    //TODO:拉伸图片
    
    self.imageIcon.imageURL = [NSURL URLWithString:huiGuangModel.imageIconURL];
    self.Image.imageURL = [NSURL URLWithString:huiGuangModel.imageURL];
    self.labTitle.text = huiGuangModel.title;
    if (huiGuangModel.commentCount > 0) {
        self.labComment.text = [NSString stringWithFormat:@"<font color='#F49B27'>%@:</font> <font color=#D2D2D2>%@</font>",[[huiGuangModel.commentList lastObject] objectForKey:@"name" ],[[huiGuangModel.commentList lastObject] objectForKey:@"comment"]];
        [self.btnAllComment setTitle:[NSString stringWithFormat:@"%d",huiGuangModel.commentCount] forState:UIControlStateNormal];
    }else{
        self.btnAllComment.enabled = NO;
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
