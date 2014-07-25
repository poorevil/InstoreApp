//
//  FocusStoreCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusStoreCell.h"


@implementation FocusStoreCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.focusStoreInterface = [[[FocusStoreInterface alloc]init]autorelease];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setView1:(FocusStoreModel *)view1{
    [_view1 release];
    _view1 = [view1 retain];
    if (view1) {
        FocusStoreView *view = [[[NSBundle mainBundle] loadNibNamed:@"FocusStoreView" owner:self options:nil] objectAtIndex:0];
        view.delegate = self;
        view.tag = 100;
        view.frame = CGRectMake(4, 0, 75, 110);
        view.storeIogo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",view1.logo]];
        if (view1.isFocus) {
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        }else{
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        }
        view.labStoreName.text = view1.title;
        [self addSubview:view];
    }
}
-(void)setView2:(FocusStoreModel *)view2{
    [_view2 release];
    _view2 = [view2 retain];
    if (view2) {
        FocusStoreView *view = [[[NSBundle mainBundle] loadNibNamed:@"FocusStoreView" owner:self options:nil] objectAtIndex:0];
        view.delegate = self;
        view.tag = 200;
        view.frame = CGRectMake(83, 0, 75, 110);
        view.storeIogo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",view2.logo]];
        if (view2.isFocus) {
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        }else{
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        }
        view.labStoreName.text = view2.title;
        [self addSubview:view];
    }
}
-(void)setView3:(FocusStoreModel *)view3{
    [_view3 release];
    _view3 = [view3 retain];
    if (view3) {
        FocusStoreView *view = [[[NSBundle mainBundle] loadNibNamed:@"FocusStoreView" owner:self options:nil] objectAtIndex:0];
        view.delegate = self;
        view.tag = 300;
        view.frame = CGRectMake(162, 0, 75, 110);
        view.storeIogo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",view3.logo]];
        if (view3.isFocus) {
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        }else{
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        }
        view.labStoreName.text = view3.title;
        [self addSubview:view];
    }
}
-(void)setView4:(FocusStoreModel *)view4{
    [_view4 release];
    _view4 = [view4 retain];
    if (view4) {
        FocusStoreView *view = [[[NSBundle mainBundle] loadNibNamed:@"FocusStoreView" owner:self options:nil] objectAtIndex:0];
        view.delegate = self;
        view.tag = 400;
        view.frame = CGRectMake(241, 0, 75, 110);
        view.storeIogo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",view4.logo]];
        if (view4.isFocus) {
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        }else{
            view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        }
        view.labStoreName.text = view4.title;
        [self addSubview:view];
    }
}

-(void)focusStoreViewHasTap:(FocusStoreView *)view{
    BOOL isFocus = NO;
    FocusStoreModel *focusStoreModel = nil;
    switch (view.tag) {
        case 100:
            isFocus = _view1.isFocus;
            focusStoreModel = _view1;
            break;
        case 200:
            isFocus = _view2.isFocus;
            focusStoreModel = _view2;
            break;
        case 300:
            isFocus = _view3.isFocus;
            focusStoreModel = _view3;
            break;
        case 400:
            isFocus = _view4.isFocus;
            focusStoreModel = _view4;
            break;
    }
    
    if (isFocus) {  //原来是喜欢，现在应该是取消喜欢
        [self.focusStoreInterface focusStoreWithID:focusStoreModel.storeID WithMethod:@"DELETE"];
        if (_delegate && [_delegate respondsToSelector:@selector(upDataFocusStoreCount:)]) {
            [_delegate upDataFocusStoreCount:NO];
        }
        view.isFocusImage.image = [UIImage imageNamed:@"focusstore_nofocus.png"];
        focusStoreModel.isFocus = NO;
//        isFocus = NO;
    }else{
        [self.focusStoreInterface focusStoreWithID:focusStoreModel.storeID WithMethod:@"PUT"];
        if (_delegate && [_delegate respondsToSelector:@selector(upDataFocusStoreCount:)]) {
            [_delegate upDataFocusStoreCount:YES];
        }
        view.isFocusImage.image = [UIImage imageNamed:@"focusstore_isfocus.png"];
        focusStoreModel.isFocus = YES;
//        isFocus = YES;
    }
}

-(void)dealloc{
    self.view1 = nil;
    self.view2 = nil;
    self.view3 = nil;
    self.view4 = nil;
    self.delegate = nil;
    self.focusStoreInterface = nil;
    
    [super dealloc];
}

@end
