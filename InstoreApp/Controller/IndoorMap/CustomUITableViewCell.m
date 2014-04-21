//
//  CustomUITableViewCell.m
//  SmartMall
//
//  Created by dujianping on 8/25/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import "CustomUITableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

#define logoWidth 60
#define logoHeight 33


@implementation CustomUIImageView

@synthesize middleImgUrl;
@synthesize originalImgUrl;

-(void)dealloc
{
    [middleImgUrl release];
    [originalImgUrl release];
    
    [super dealloc];
}

@end

@implementation CustomUITableViewCell

@synthesize bageImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CALayer *layer = [self.imageView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:4.0];
        [layer setBorderWidth:1];
        //设置边框线的颜色
        [layer setBorderColor:[[UIColor colorWithRed:175.0/255 green:175.0/255 blue:175.0/255 alpha:1] CGColor]];
        
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.backgroundColor = [UIColor greenColor];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        self.detailTextLabel.backgroundColor = [UIColor yellowColor];
        
        // Initialization code
        UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        aImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.bageImageView = aImageView;
        [self.contentView addSubview:aImageView];
        [aImageView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    NSString *path = [[NSBundle mainBundle] pathForResource:@"listitem_selected" ofType:@"png"];
    self.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]] autorelease];
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    self.selectedBackgroundView.frame = CGRectMake(0, 0, screenSize.size.width, 60);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin_x = 5;
    CGFloat y = (self.bounds.size.height - logoHeight) / 2;
    CGRect imgFrame = self.imageView.frame;
    imgFrame.size.width = logoWidth;
    imgFrame.size.height = logoHeight;
    imgFrame.origin.x = 9;
    imgFrame.origin.y = y;
    self.imageView.frame = imgFrame;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    if (self.bageImageView.image != nil) {
        CGRect bageViewFrame = CGRectZero;
        bageViewFrame.origin.x = imgFrame.origin.x + imgFrame.size.width - 6;
        bageViewFrame.origin.y = y + logoHeight - 5;
        bageViewFrame.size.width = 13;
        bageViewFrame.size.height = 13;
        self.bageImageView.frame = bageViewFrame;
        [self.contentView bringSubviewToFront:bageImageView];
        [self.bageImageView setHidden:NO];
    }else{
        [self.bageImageView setHidden:YES];
    }
    
    CGRect textlabelFrame = self.textLabel.frame;
    CGFloat secondColum_x = imgFrame.origin.x + imgFrame.size.width;
    if (textlabelFrame.origin.x - secondColum_x != margin_x) {
        if (textlabelFrame.origin.y < 0) {
            textlabelFrame.origin.y = 9;
        }
        textlabelFrame.origin.x = secondColum_x + margin_x;
        self.textLabel.frame = textlabelFrame;
    }    
    CGRect detailTextlebelFrame = self.detailTextLabel.frame;
    if (detailTextlebelFrame.origin.x - secondColum_x != margin_x) {
        detailTextlebelFrame.origin.x = secondColum_x + margin_x;
        self.detailTextLabel.frame = detailTextlebelFrame;
    }
}

- (void)dealloc
{
    [bageImageView release];
    
    [super dealloc];
}

@end

@implementation CustomUITableViewCellImageViewOnTop

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imageView_x = (self.contentView.frame.size.width - self.imageView.image.size.width) / 2;
    CGFloat margin_y = 10;
    self.imageView.frame = CGRectMake(imageView_x, margin_y, logoWidth, logoHeight);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    CALayer *layer = [self.imageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0];
    [layer setBorderWidth:1];
    //设置边框线的颜色
    [layer setBorderColor:[[UIColor colorWithRed:175.0/255 green:175.0/255 blue:175.0/255 alpha:1] CGColor]];
    
    CGRect textLabelFrame = self.textLabel.frame;
    CGFloat margin_x = 10;
    CGFloat groupedTableViewMargin = GROUPED_LISTVIEW_MARGIN_TO_SIDE_IPHONE;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        groupedTableViewMargin = GROUPED_LISTVIEW_MARGIN_TO_SIDE_IPAD;
    }
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor colorWithRed:56.0/255.0
                                                green:84.0/255.0
                                                 blue:135.0/255.0
                                                alpha:1];
    textLabelFrame.origin.x = margin_x;
    textLabelFrame.origin.y = logoHeight + 2 * margin_y;
    textLabelFrame.size.width = self.frame.size.width - 2 * (groupedTableViewMargin + margin_x);
    UIFont *cellFont = [UIFont systemFontOfSize:14.0];
    CGSize constraintSize = CGSizeMake(textLabelFrame.size.width, MAXFLOAT);
    CGSize textLabelSize = [self.textLabel.text sizeWithFont:cellFont 
                                           constrainedToSize:constraintSize 
                                               lineBreakMode:UILineBreakModeWordWrap];
    textLabelFrame.size.height = textLabelSize.height;
    
    self.textLabel.frame = textLabelFrame;
}

- (void)dealloc
{
    [super dealloc];
}

@end


@implementation CustomUITableViewCellOneImage

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // self.frame = CGRectMake(0, 0, 320, 200);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.textLabel removeFromSuperview];
    [self.detailTextLabel removeFromSuperview];
    [self.accessoryView removeFromSuperview];
    
    CGFloat margin = 10;
    self.imageView.frame = CGRectMake(margin, 
                                      margin, 
                                      self.frame.size.width - 2 * margin, 
                                      self.frame.size.height - 2 * margin);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    CALayer *layer = [self.imageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0];
    [layer setBorderWidth:1];
    //设置边框线的颜色
    [layer setBorderColor:[[UIColor colorWithRed:175.0/255 green:175.0/255 blue:175.0/255 alpha:1] CGColor]];
}

- (void)dealloc
{
    [super dealloc];
}

@end

@implementation CustomUITableViewCellForStoreOverView

#define IMG_VIEW_X        10
#define IMG_VIEW_Y        15
#define IMG_VIEW_WIDTH    60
#define IMG_VIEW_HEIGHT   60
#define ELEMENT_MARGIN_X  5

#define CELL_HEIGHT       86

@synthesize positionTextLabel;
@synthesize telTextLabel;
@synthesize addressTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect screenSize = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 0, screenSize.size.width, CELL_HEIGHT);
        positionTextLabel = [[UILabel alloc] init];
        telTextLabel= [[UILabel alloc] init];
        addressTextLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:positionTextLabel];
        [self.contentView addSubview:telTextLabel];
        [self.contentView addSubview:addressTextLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(IMG_VIEW_X, IMG_VIEW_Y, IMG_VIEW_WIDTH, IMG_VIEW_HEIGHT);
    self.imageView.bounds = CGRectMake(IMG_VIEW_X, IMG_VIEW_Y, IMG_VIEW_WIDTH, IMG_VIEW_HEIGHT);
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    CALayer *layer = [self.imageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0];
    [layer setBorderWidth:1];
    //设置边框线的颜色
    [layer setBorderColor:[[UIColor colorWithRed:175.0/255 
                                           green:175.0/255 
                                            blue:175.0/255 
                                           alpha:1] CGColor]];
    
    CGFloat ctrHeight = 15;
    CGFloat textLabel_X = IMG_VIEW_X + IMG_VIEW_WIDTH + ELEMENT_MARGIN_X;
    CGFloat lineOneText_Y = IMG_VIEW_Y;
    CGFloat lineOneWidth = self.frame.size.width - textLabel_X - ELEMENT_MARGIN_X;
    self.textLabel.font = [UIFont systemFontOfSize:17];
    self.textLabel.numberOfLines = 0;
    CGSize ssize = [self.textLabel sizeThatFits:CGSizeMake(lineOneWidth, 0)];
    
    self.positionTextLabel.font = [UIFont systemFontOfSize:17];
    self.positionTextLabel.textColor = [UIColor colorWithRed:52.0/255 
                                                       green:139.0/255 
                                                        blue:206.0/255 
                                                       alpha:1];
    self.positionTextLabel.backgroundColor = [UIColor clearColor];
    self.positionTextLabel.numberOfLines = 0;
    CGSize positionLabelSize = [self.positionTextLabel sizeThatFits:CGSizeMake(lineOneWidth, 0)];
    if (ssize.width + positionLabelSize.width + ELEMENT_MARGIN_X > lineOneWidth) 
    {
        ssize.width = lineOneWidth - positionLabelSize.width - ELEMENT_MARGIN_X;
    }
    self.textLabel.frame = CGRectMake(textLabel_X, lineOneText_Y, 
                                      ssize.width, ssize.height);
    CGFloat positionTextLabel_X = textLabel_X + self.textLabel.frame.size.width + ELEMENT_MARGIN_X;
    self.positionTextLabel.frame = CGRectMake(positionTextLabel_X, 
                                              lineOneText_Y, 
                                              positionLabelSize.width, 
                                              positionLabelSize.height);
    
    CGFloat lineTwoText_Y = lineOneText_Y + 20 + 8;
    self.telTextLabel.font = [UIFont systemFontOfSize:12];
    self.telTextLabel.textColor = [UIColor blackColor];
    self.telTextLabel.backgroundColor = [UIColor clearColor];
    self.telTextLabel.numberOfLines = 0;
    ssize = [self.telTextLabel sizeThatFits:CGSizeMake(80, 0)];
    self.telTextLabel.frame = CGRectMake(textLabel_X, lineTwoText_Y, ssize.width, ssize.height);
    
    CGFloat telTextLabel_X = textLabel_X + self.telTextLabel.frame.size.width + ELEMENT_MARGIN_X;
    CGFloat telTextLabelWidth = self.frame.size.width - telTextLabel_X - ELEMENT_MARGIN_X;
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    self.detailTextLabel.textColor = [UIColor colorWithRed:52.0/255 green:139.0/255 blue:206.0/255 alpha:1];
    self.detailTextLabel.frame = CGRectMake(telTextLabel_X, lineTwoText_Y, telTextLabelWidth, ssize.height);
    
    CGFloat lineThreeText_Y = lineTwoText_Y + 15;
    self.addressTextLabel.font = [UIFont systemFontOfSize:12];
    self.addressTextLabel.numberOfLines = 0;
    self.addressTextLabel.backgroundColor = [UIColor clearColor];
    ssize = [self.addressTextLabel sizeThatFits:CGSizeMake(220, 0)];
    self.addressTextLabel.frame = CGRectMake(textLabel_X, 
                                             lineThreeText_Y, 
                                             ssize.width, 
                                             ctrHeight);
}

- (void)dealloc
{
    [self.positionTextLabel removeFromSuperview];
    [self.telTextLabel removeFromSuperview];
    [self.addressTextLabel removeFromSuperview];
    
    /*
    [self.positionTextLabel release];
    [self.telTextLabel release];
    [self.addressTextLabel release];*/
    
    //Fixed By Jacky
    [positionTextLabel release];
    [telTextLabel release];
    [addressTextLabel release];
    
    [super dealloc];
}

@end