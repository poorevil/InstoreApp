//
//  UserInfoViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
#import "UpdateUserInfoInterface.h"

@interface UserInfoViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (retain, nonatomic) UserInfoModel *userInfoModel;
@property (retain, nonatomic) UIPickerView *genderPickerView;
@property (retain, nonatomic) NSArray *genderList;
@property (retain, nonatomic) UIDatePicker *birthdayPickerView;
@property (assign, nonatomic) int textFiledCount;
@property (assign, nonatomic) BOOL isEditor;

@property (retain, nonatomic) UpdateUserInfoInterface *updateUserInfoInterface;

@property (retain, nonatomic) IBOutlet UITextField *textFieldNickName;
@property (retain, nonatomic) IBOutlet UITextField *textFieldGender;
@property (retain, nonatomic) IBOutlet UITextField *textFieldBirthday;

@end
