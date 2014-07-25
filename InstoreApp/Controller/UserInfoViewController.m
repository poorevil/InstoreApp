//
//  UserInfoViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "UserInfoViewController.h"
#import "NSDate+DynamicDateString.h"
#import "NSDate+DynamicDateString.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"个人资料";
    self.hidesBottomBarWhenPushed = YES;

    self.textFieldNickName.text = self.userInfoModel.nickName;
    switch (self.userInfoModel.gender) {
        case 0:
            self.textFieldGender.text = @"未选择";
            break;
        case 1:
            self.textFieldGender.text = @"男";
            break;
        case 2:
            self.textFieldGender.text = @"女";
            break;
    }
    self.textFieldBirthday.text = [self.userInfoModel.birthday toDateString];
    
    self.isEditor = NO;
    UIButton *btnEditor = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEditor.frame = CGRectMake(0, 0, 38, 19);
    [btnEditor setImage:[UIImage imageNamed:@"bankcard_editor.png"] forState:UIControlStateNormal];
    [btnEditor setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [btnEditor addTarget:self action:@selector(btnEditorAction:) forControlEvents:UIControlEventTouchUpInside];
    btnEditor.tag = 101;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btnEditor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [rightBtn release];
    
    self.genderPickerView = [[[UIPickerView alloc]initWithFrame:CGRectMake(0, DeviceHeight, 320, 162)]autorelease];
    self.genderPickerView.delegate = self;
    self.genderPickerView.dataSource = self;
    [self.view addSubview:self.genderPickerView];
    
    self.birthdayPickerView  = [[[UIDatePicker alloc]initWithFrame:CGRectMake(0, DeviceHeight , 320, 162)]autorelease];
    self.birthdayPickerView.datePickerMode = UIDatePickerModeDate;
    self.birthdayPickerView.locale = [[[NSLocale alloc]initWithLocaleIdentifier:@"zh"]autorelease];
    self.birthdayPickerView.minimumDate = [NSDate dateFromString:@"1970-01-01 00:00:00 -0500"];
    self.birthdayPickerView.maximumDate = [NSDate dateFromString:@"2000-01-01 00:00:00 -0500"];
    [self.view addSubview:_birthdayPickerView];
    
    self.genderList = @[@"男",@"女"];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    self.updateUserInfoInterface = [[[UpdateUserInfoInterface alloc]init]autorelease];
//    self.updateUserInfoInterfac
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.genderList objectAtIndex:row];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.isEditor == NO) {
        return NO;
    }
    [self resetPickViewFrameZero];
    switch (textField.tag) {
        case 100:
            return YES;
            break;
        case 200:{
            self.textFiledCount = 200;
            [self pickViewAppear:self.genderPickerView];
        }
            break;
        case 300:{
            self.textFiledCount = 300;
            [self pickViewAppear:self.birthdayPickerView];
        }
            break;
    }
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 100) {
        if (textField.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"昵称不能为空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return NO;
        }
    }
    [textField resignFirstResponder];
    return YES;
}
-(void)pickViewAppear:(UIView *)picker{
    if (picker.frame.origin.y >= DeviceHeight) {
        [UIView animateWithDuration:0.6 animations:^(void){
            CGRect frame = picker.frame;
            frame.origin.y -= 162;
            picker.frame = frame;
        }];
    }
}
-(void)pickViewDisAppear:(UIView *)picker{
    if (picker.frame.origin.y < DeviceHeight) {
        [UIView animateWithDuration:0.6 animations:^(void){
            CGRect frame = picker.frame;
            frame.origin.y += 162;
            picker.frame = frame;
        }];
    }
}
-(void)resetPickViewFrameZero{
    self.genderPickerView.frame = CGRectMake(0, DeviceHeight, 320, 162);
    self.birthdayPickerView.frame = CGRectMake(0, DeviceHeight, 320, 162);
}
-(void)tapAction:(UIGestureRecognizer *)ges{
    if (self.textFiledCount == 200) {
        self.textFieldGender.text = [self.genderList objectAtIndex:[self.genderPickerView selectedRowInComponent:0]];
        [self.textFieldGender resignFirstResponder];
        [self pickViewDisAppear:self.genderPickerView];
    }else if (self.textFiledCount == 300){
        NSDate *date = [self.birthdayPickerView date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *string = [formatter stringFromDate:date];
        self.textFieldBirthday.text = string;
        [formatter release];
        [self.textFieldBirthday resignFirstResponder];
        [self pickViewDisAppear:self.birthdayPickerView];
    }
}
-(void)btnEditorAction:(UIButton *)sender{
    if (self.isEditor == NO) {
        [sender setImage:[UIImage imageNamed:@"updateUserInfo_ok.png"] forState:UIControlStateNormal];
        [self.textFieldNickName becomeFirstResponder];
        self.isEditor = YES;
    }else{
        [sender setImage:[UIImage imageNamed:@"bankcard_editor.png"] forState:UIControlStateNormal];
        [self.textFieldNickName resignFirstResponder];
//        [self.textFieldGender resignFirstResponder];
//        [self.textFieldBirthday resignFirstResponder];
        [self resetPickViewFrameZero];
        self.isEditor = NO;
        
        NSInteger gender;
        if ([self.textFieldGender.text isEqualToString:@"男"]) {
            gender = 1;
        }else{
            gender = 2;
        }
        
        [self.updateUserInfoInterface updateUserInfoWithName:nil Gender:gender NickName:self.textFieldNickName.text Email:nil Birthday:self.textFieldBirthday.text];        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.userInfoModel = nil;
    self.genderPickerView = nil;
    self.birthdayPickerView = nil;
    [_textFieldNickName release];
    [_textFieldGender release];
    [_textFieldBirthday release];
    [super dealloc];
}
@end
