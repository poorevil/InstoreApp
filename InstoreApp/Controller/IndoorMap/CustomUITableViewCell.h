//
//  CustomUITableViewCell.h
//  SmartMall
//
//  Created by dujianping on 8/25/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomUIImageView : UIImageView {
    
}

@property (nonatomic, retain) NSString *middleImgUrl;
@property (nonatomic, retain) NSString *originalImgUrl;

@end

@interface CustomUITableViewCell : UITableViewCell {
    
}

@property (nonatomic, retain) UIImageView *bageImageView;

@end

@interface CustomUITableViewCellImageViewOnTop : UITableViewCell {
    
}

@end


@interface CustomUITableViewCellOneImage : UITableViewCell {

}
@end


@interface CustomUITableViewCellForStoreOverView : UITableViewCell {
    
}

@property (nonatomic, retain) UILabel *positionTextLabel;
@property (nonatomic, retain) UILabel *telTextLabel;
@property (nonatomic, retain) UILabel *addressTextLabel;

@end
