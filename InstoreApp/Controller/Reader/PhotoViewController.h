//
//  PhotoAlbumViewController.h
//  VDiskMobile
//
//  Created by hanchao on 13-8-22.
//
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (nonatomic,retain) NSMutableArray *fileListData;
@property (nonatomic,retain) id metadata;

@property (nonatomic,assign) BOOL shareActionLock;

@property (nonatomic, assign) BOOL showDirectly;


//
//@property (nonatomic, retain) UIDocumentInteractionController *docController;
//
//- (UIDocumentInteractionController *)docControllerForFile:(NSURL *)fileURL;
//
//- (void)presentOptionsMenu;
//- (void)unavailableReader;
//
//- (void)shareAction:(id)sender;
//- (void)updateFrame;
//
//- (void)shareWithMail:(VdiskMetadata *)metadata;
//- (void)shareWithWeibo:(VdiskMetadata *)metadata;
//- (void)shareWithSMS:(VdiskMetadata *)metadata;

@end
