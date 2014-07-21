//
//  BindPhoneViewController.h
//  InstoreApp
//
//  Created by han chao on 14-4-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindPhoneViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITextField *phoneNumField;
@property (nonatomic,strong) IBOutlet UITextField *checkNumField;
@property (nonatomic,strong) IBOutlet UIButton *fetchCheckNumBtn;
@property (nonatomic,strong) IBOutlet UIButton *bindPhoneBtn;
@property (nonatomic,strong) IBOutlet UIButton *findAccountBtn;

@end
