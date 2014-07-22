//
//  QrCodeViewCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface QrCodeViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet EGOImageView *imageQrCode;
@property (retain, nonatomic) IBOutlet UILabel *labQRCode;

@end
