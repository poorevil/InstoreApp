//
//  BindingVIPCardViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindingVIPCardViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *labVIPCardNum;
@property (retain, nonatomic) IBOutlet UITextField *labPhoneNum;
@property (retain, nonatomic) IBOutlet UIButton *btnBindingVIPCard;
- (IBAction)btnBindingVIPCardAction:(UIButton *)sender;

@end
