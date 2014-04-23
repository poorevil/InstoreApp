//
//  FloorSelectViewController.h
//  InstoreApp
//  楼层筛选
//  Created by evil on 14-4-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FloorModel;
@protocol FloorSelectViewControllerDelegate <NSObject>

@required
-(void)floorSelectDidFinished:(FloorModel *) floorModel;

@end

@interface FloorSelectViewController : UIViewController

@property (nonatomic,assign) id<FloorSelectViewControllerDelegate> delegate;

-(id)initWithFloorModel:(FloorModel *)floorModel;

@end
