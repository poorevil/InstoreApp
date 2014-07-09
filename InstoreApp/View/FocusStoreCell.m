//
//  FocusStoreCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusStoreCell.h"
#import "FocusStoreView.h"

@implementation FocusStoreCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setView1:(FocusStoreModel *)view1{
    if (view1) {
        FocusStoreView *view = [[FocusStoreView alloc]init];
        view.frame = CGRectMake(4, 0, 75, 110);
        view.storeIogo.imageURL = [NSURL URLWithString:view1.logo];
        if (view1.isFocus) {
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        }else{
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        }
        view.labStoreName.text = view1.title;
    }
}
-(void)setView2:(FocusStoreModel *)view2{
    if (view2) {
        FocusStoreView *view = [[FocusStoreView alloc]init];
        view.frame = CGRectMake(83, 0, 75, 110);
        view.storeIogo.imageURL = [NSURL URLWithString:view2.logo];
        if (view2.isFocus) {
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        }else{
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        }
        view.labStoreName.text = view2.title;
    }
}
-(void)setView3:(FocusStoreModel *)view3{
    if (view3) {
        FocusStoreView *view = [[FocusStoreView alloc]init];
        view.frame = CGRectMake(162, 0, 75, 110);
        view.storeIogo.imageURL = [NSURL URLWithString:view3.logo];
        if (view3.isFocus) {
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        }else{
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        }
        view.labStoreName.text = view3.title;
    }
}
-(void)setView4:(FocusStoreModel *)view4{
    if (view4) {
        FocusStoreView *view = [[FocusStoreView alloc]init];
        view.frame = CGRectMake(241, 0, 75, 110);
        view.storeIogo.imageURL = [NSURL URLWithString:view4.logo];
        if (view4.isFocus) {
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        }else{
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        }
        view.labStoreName.text = view4.title;
    }
}

-(void)dealloc{
    self.view1 = nil;
    self.view2 = nil;
    self.view3 = nil;
    self.view4 = nil;
    
    [super dealloc];
}

@end
